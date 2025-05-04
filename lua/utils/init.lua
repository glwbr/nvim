-- Gener(al/ic)? helper functions

local M = {}

---@param bufnr integer
---@param ... string
---@return string
function M.first(bufnr, ...)
  local conform = require 'conform'
  for i = 1, select('#', ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

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

return M
