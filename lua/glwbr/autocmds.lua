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

autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
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

  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local cursor_pos = vim.fn.getpos '.'

  local function handle_eslint_output(_, data)
    if not (data and #data > 1) then
      return
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
    vim.fn.setpos('.', cursor_pos)
  end

  local function handle_eslint_error(_, data)
    if data and #data > 1 then
      vim.notify(table.concat(data, '\n'), vim.log.levels.ERROR)
    end
  end

  local job_id = vim.fn.jobstart({ 'eslint_d', '--stdin', '--fix-to-stdout', '--stdin-filename', filename }, {
    stdout_buffered = true,
    on_stdout = handle_eslint_output,
    on_stderr = handle_eslint_error,
  })

  if job_id > 0 then
    vim.fn.chansend(job_id, table.concat(content, '\n'))
    vim.fn.chanclose(job_id, 'stdin')
  end
end, { desc = 'Fix ESLint issues in current buffer' })

autocmd('User', {
  pattern = 'BlinkCmpMenuOpen',
  callback = function()
    require('copilot.suggestion').dismiss()
    vim.b.copilot_suggestion_hidden = true
  end,
})

autocmd('User', {
  pattern = 'BlinkCmpMenuClose',
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})
