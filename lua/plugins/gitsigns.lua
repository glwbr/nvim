local utils = require 'utils'
local catUtils = require 'utils.cats'

local map = utils.map

return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  enabled = catUtils.enableForCategory 'qualityOfLife',
  opts = {
    current_line_blame = true,
    current_line_blame_opts = { delay = 500 },
    current_line_blame_formatter = '<author> • <author_time:%R> - <summary>',
    current_line_blame_formatter_nc = 'Uncommitted changes',
    numhl = false,
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '│' },
      topdelete = { text = '│' },
      changedelete = { text = '│' },
      untracked = { text = '│' },
    },
    on_attach = function()
      local gs = require 'gitsigns'

      map('n', 'gj', function()
        if vim.wo.diff then
          vim.cmd.normal { 'gj', bang = true }
        else
          gs.nav_hunk 'next'
        end
      end, { desc = 'Git Next Hunk' })

      map('n', 'gk', function()
        if vim.wo.diff then
          vim.cmd.normal { 'gk', bang = true }
        else
          gs.nav_hunk 'prev'
        end
      end, { desc = 'Git Previous Hunk' })

      map('n', '<leader>gD', gs.diffthis, { desc = '[G]it [D]iff This' })
    end,
  },
}
