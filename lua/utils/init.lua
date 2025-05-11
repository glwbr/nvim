-- Gener(al/ic)? helper functions

local M = {}

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = opts.silent == nil and true or opts.silent
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.add_trailing_comma_if_needed()
  local line = vim.api.nvim_get_current_line()

  local should_add_comma = string.find(line, '[^,{[]$')
  if should_add_comma then
    return 'A,<cr>'
  else
    return 'o'
  end
end

---Lightens a hex color by a specific amount
---@param hex_color string The hex color code (with or without leading #)
---@param amount number The amount to lighten each RGB component (0-255)
---@return string The lightened hex color with # prefix
function M.lighten_color(hex_color, amount)
  hex_color = hex_color:lower():gsub('^#', '')

  local r = tonumber(hex_color:sub(1, 2), 16)
  local g = tonumber(hex_color:sub(3, 4), 16)
  local b = tonumber(hex_color:sub(5, 6), 16)

  r = math.min(255, r + amount)
  g = math.min(255, g + amount)
  b = math.min(255, b + amount)

  return string.format('#%02x%02x%02x', r, g, b)
end

return M
