-- nixCats helper functions, credits: https://github.com/BirdeeHub/birdeeSystems

local M = {}

---@type boolean
M.isNixCats = vim.g[ [[nixCats-special-rtp-entry-nixCats]] ] ~= nil

---@class nixCatsSetupOpts
---@field non_nix_value boolean|nil

---This function will setup a mock nixCats plugin when not using nix
---It will help prevent you from running into indexing errors without a nixCats plugin from nix.
---If you loaded the config via nix, it does nothing
---non_nix_value defaults to true if not provided or is not a boolean.
---@param v nixCatsSetupOpts
function M.setup(v)
  if not M.isNixCats then
    local nixCats_default_value
    if type(v) == 'table' and type(v.non_nix_value) == 'boolean' then
      nixCats_default_value = v.non_nix_value
    else
      nixCats_default_value = true
    end
    local mk_with_meta = function(tbl)
      return setmetatable(tbl, {
        __call = function(_, attrpath)
          local strtable = {}
          if type(attrpath) == 'table' then
            strtable = attrpath
          elseif type(attrpath) == 'string' then
            for key in attrpath:gmatch '([^%.]+)' do
              table.insert(strtable, key)
            end
          else
            print 'function requires a table of strings or a dot separated string'
            return
          end
          return vim.tbl_get(tbl, unpack(strtable))
        end,
      })
    end
    package.preload['nixCats'] = function()
      local ncsub = {
        get = function(_)
          return nixCats_default_value
        end,
        cats = mk_with_meta {
          nixCats_config_location = vim.fn.stdpath 'config',
          wrapRc = false,
        },
        settings = mk_with_meta {
          nixCats_config_location = vim.fn.stdpath 'config',
          configDirName = os.getenv 'NVIM_APPNAME' or 'nvim',
          wrapRc = false,
        },
        petShop = mk_with_meta {},
        extra = mk_with_meta {},
        pawsible = mk_with_meta {
          allPlugins = {
            start = {},
            opt = {},
          },
        },
        configDir = vim.fn.stdpath 'config',
        packageBinPath = os.getenv 'NVIM_WRAPPER_PATH_NIX' or vim.v.progpath,
      }
      return setmetatable(ncsub, {
        __call = function(_, cat)
          return ncsub.get(cat)
        end,
      })
    end
    _G.nixCats = require 'nixCats'
  end
end

---guarantee a boolean is returned, and also declare a different
---default value than specified in setup when not using nix to load the config
---@overload fun(v: string|string[]): boolean
---@overload fun(v: string|string[], default: boolean): boolean
function M.enableForCategory(v, default)
  if M.isNixCats or default == nil then
    if nixCats(v) then
      return true
    else
      return false
    end
  else
    return default
  end
end

---@param cats string|string[] Categories to look up in nixCats if using Nix
---@param nonNixValue any Value to use when not using Nix
---@return any
function M.nixCatOr(cats, nonNixValue)
  if M.isNixCats then
    nixCats(cats)
  else
    return nonNixValue
  end
end

--- Returns a value based on whether or not you're in a Nix environment.
--- @param value any The value to return if not in Nix environment.
function M.ifNotNix(value)
  if M.isNixCats then
    return false
  else
    return value
  end
end

return M
