local catUtils = require 'utils.cats'
local lazyUtils = require 'utils.lazy'

local function getlockfilepath()
  if catUtils.isNixCats and type(nixCats.settings.unwrappedCfgPath) == 'string' then
    return nixCats.settings.unwrappedCfgPath .. '/lazy-lock.json'
  else
    return vim.fn.stdpath 'config' .. '/lazy-lock.json'
  end
end

local lazyOptions = { lockfile = getlockfilepath() }

lazyUtils.setup(nixCats.pawsible { 'allPlugins', 'start', 'lazy.nvim' }, {
  { import = 'plugins' },
}, lazyOptions)
