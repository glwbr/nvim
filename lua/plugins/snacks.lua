local utils = require 'utils'
local map = utils.map

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    words = { enabled = false },
    bigfile = { enabled = true },
    notifier = { enabled = true, style = 'minimal', top_down = false },
    picker = {
      enable = true,
      ui_select = true,
      layout = {
        layout = {
          backdrop = false,
        },
      },
      win = {
        preview = { wo = { foldcolumn = '0', number = false, relativenumber = false, signcolumn = 'no' } },
      },
    },
  },
  keys = {
    { '<leader>/', function() Snacks.picker.grep_buffers() end, desc = ' Fuzzily search in current buffer' },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },
    { '<leader>ff', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
    { '<leader>rf', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
    { '<leader>sb', function() Snacks.picker.buffers() end, desc = '[ ] Find Existing Buffers' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
    { '<leader>sf', function() Snacks.picker.smart() end, desc = '[S]earch [F]iles' },
    { '<leader>sg', function() Snacks.picker.git_grep() end, desc = '[S]earch [/] in Open Files' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp Tags' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eybindings' },
    { '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config', title = 'Neovim Files' }
      end,
      desc = '[S]earch [N]eovim Config Files',
    },
    { '<leader>sp', function() Snacks.picker.projects() end, desc = '[S]earch [P]projects' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = '[S]earch [S] Built-in Pickers' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch Current [W]ord' },
  },
}
