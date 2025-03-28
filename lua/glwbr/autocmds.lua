local api = vim.api
local autocmd = api.nvim_create_autocmd
local usercmd = api.nvim_create_user_command

local function augroup(name)
  return api.nvim_create_augroup('user_' .. name, { clear = true })
end

autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
  desc = 'Reload the file when changed externally',
})

autocmd('FileType', {
  group = augroup 'close_with_esc',
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'gitsigns-blame',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', '<Esc>', function()
        vim.cmd 'close'
        pcall(api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
  desc = 'Close certain buffers with <Esc>',
})

autocmd({ 'TextYankPost' }, {
  group = augroup 'highlight_yank',
  callback = function()
    (vim.hl or vim.highlight).on_yank { timeout = 50 }
  end,
  desc = 'Highlight on Yank',
})

autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
  desc = 'Resize splits if window got resized',
})

autocmd({ 'BufWritePre' }, {
  group = augroup 'auto_create_dir',
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
  desc = 'Create parent directories when saving new files',
})

autocmd({ 'BufReadPost' }, {
  group = augroup 'last_location',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = api.nvim_buf_get_mark(buf, '"')
    local lcount = api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = 'Go to last location when opening a buffer',
})

autocmd({ 'User' }, {
  group = augroup 'oil',
  pattern = 'OilActionsPost',
  callback = function(event)
    if event.data.actions.type == 'move' then
      Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
    end
  end,
  desc = 'Handle file renaming in Oil.nvim with Snacks.rename',
})

autocmd({ 'FileType' }, {
  group = augroup 'vertical_help',
  pattern = 'help',
  callback = function()
    vim.bo.bufhidden = 'unload'
    vim.cmd.wincmd 'L'
    vim.cmd.wincmd '='
  end,
  desc = 'Open help in a vertical split',
})

autocmd({ 'FileType' }, {
  group = augroup 'oil',
  pattern = 'oil',
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
  desc = 'Hide colorcolumn when  browsing files',
})

usercmd('EslintFix', function()
  if vim.fn.executable 'eslint_d' ~= 1 then
    vim.notify('eslint_d not found in PATH', vim.log.levels.ERROR)
    return
  end

  local cursor_pos = vim.fn.getpos '.'
  vim.cmd '%!eslint_d --stdin --fix-to-stdout --stdin-filename %'
  vim.fn.setpos('.', cursor_pos)
end, { desc = 'Fix ESLint issues in current buffer' })
