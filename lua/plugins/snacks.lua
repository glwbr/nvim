local utils = require 'utils'
local map = utils.map

return {
  'folke/snacks.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = { enabled = true },
  },
  keys = {
    {
      '<leader>,',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
  },
  config = function()
    map('n', '<leader>ff', Snacks.picker.smart, { desc = '[S]earch [F]iles' })
    map('n', '<leader>/', Snacks.picker.grep_buffers, { desc = '[/] Fuzzily search in current buffer' })
    map('n', '<leader>s.', Snacks.picker.recent, { desc = '[S]earch Recent Files ("." for repeat)' })
    map('n', '<leader>s/', Snacks.picker.grep_buffers, { desc = '[S]earch [/] in Open Files' })
    map('n', '<leader>sd', Snacks.picker.diagnostics, { desc = '[S]earch [D]iagnostics' })
    map('n', '<leader>sf', Snacks.picker.files, { desc = '[S]earch [F]iles' })
    map('n', '<leader>sh', Snacks.picker.help, { desc = '[S]earch [H]elp Tags' })
    map('n', '<leader>sk', Snacks.picker.keymaps, { desc = '[S]earch [K]eybindings' })
    map('n', '<leader>sn', function()
      Snacks.picker.files { cwd = vim.fn.stdpath 'config', title = 'Neovim Files' }
    end, { desc = '[S]earch [N]eovim Config Files' })
    map('n', '<leader>sp', Snacks.picker.projects, { desc = '[S]earch [P]projects' })
    map('n', '<leader>sr', Snacks.picker.resume, { desc = '[S]earch [R]esume' })
    map('n', '<leader>ss', Snacks.picker.pickers, { desc = '[S]earch [S] Built-in Pickers' })
    map('n', '<leader>sw', Snacks.picker.grep_word, { desc = '[S]earch Current [W]ord' })
    map('n', '<leader><leader>', Snacks.picker.buffers, { desc = '[ ] Find Existing Buffers' })
  end,
}
