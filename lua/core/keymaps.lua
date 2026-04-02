local map = require('utils').map

-- Diagnostic Navigation
local diagnostic_goto = function(next, severity)
  local count = next and 1 or -1
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump { count = count, severity = severity }
  end
end

map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- Window management
map('n', '<leader>pv', '<cmd>Oil<CR>', { desc = 'Open File Explorer' })
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })

-- Close window in direction
local function close_win_in_dir(dir)
  local cur = vim.api.nvim_get_current_win()
  vim.cmd('wincmd ' .. dir)
  local target = vim.api.nvim_get_current_win()
  if target ~= cur then
    vim.api.nvim_win_close(target, false)
  end
end

map('n', '<leader>wh', function() close_win_in_dir('h') end, { desc = 'Close Left Window' })
map('n', '<leader>wl', function() close_win_in_dir('l') end, { desc = 'Close Right Window' })
map('n', '<leader>wj', function() close_win_in_dir('j') end, { desc = 'Close Below Window' })
map('n', '<leader>wk', function() close_win_in_dir('k') end, { desc = 'Close Above Window' })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Go to Left Split', remap = true })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Go to Right Split', remap = true })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Go to Upper Split', remap = true })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Go to Lower Split', remap = true })
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- List management
map('n', '<leader>xl', function()
  local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Location List' })

map('n', '<leader>xq', function()
  local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Quickfix List' })

map('n', '[q', function()
  local ok, err = pcall(vim.cmd.cprev)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Previous Quickfix' })
map('n', ']q', function()
  local ok, err = pcall(vim.cmd.cnext)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Next Quickfix' })

-- Search navigation
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Indentation
map('v', '<', '<gv', { desc = 'Indent Left' })
map('v', '>', '>gv', { desc = 'Indent Right' })

-- Clipboard management
map('n', '<leader>d', '"_d', { desc = 'Delete (no clipboard)' })
map('v', '<leader>d', '"_d', { desc = 'Delete (no clipboard)' })
map('n', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
map('v', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
map('n', '<leader>Y', '"+Y', { desc = 'Yank Line to clipboard' })
map('x', '<leader>p', '"_dP', { desc = 'Paste over selection (no clipboard)' })
map('n', 'x', '"_x', { desc = 'Delete char (no clipboard)' })

-- Text manipulation
map('n', 'J', 'mzJ`z', { desc = 'Join Lines' })
map('n', '+', '<C-a>', { desc = 'Increment numbers', noremap = true })
map('n', '-', '<C-x>', { desc = 'Decrement numbers', noremap = true })
map('v', '+', 'g<C-a>', { desc = 'Increment numbers', noremap = true })
map('n', '<leader>sr', '<cmd>%s/\\<<c-r><c-w>\\>/', { desc = 'Replace word under cursor' })

-- Smart insert (preserves indentation on empty lines)
map('n', 'i', function()
  local line = vim.fn.getline '.'
  return line:match '^%s*$' and [["_cc]] or 'i'
end, { desc = 'Smart insert: preserves indent on blank lines', expr = true, noremap = true })

-- Session management
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })

-- Utilities
map('n', 'Q', '<nop>', { desc = 'Disable Q' })
map({ 'i', 'n', 's' }, '<esc>', function()
  vim.cmd 'noh'
  return '<esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })
