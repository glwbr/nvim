local utils = require 'utils'
local catUtils = require 'utils.cats'

local map = utils.map

return {
  'lewis6991/gitsigns.nvim',
  enabled = catUtils.enableForCategory 'qualityOfLife',
  opts = {
    current_line_blame = true,
    current_line_blame_formatter = '<author> • <author_time:%R> <summary>',
    current_line_blame_formatter_nc = 'Uncommitted changes',
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '│' },
      topdelete = { text = '│' },
      changedelete = { text = '│' },
      untracked = { text = '│' },
    },
    on_attach = function()
      local gitsigns = require 'gitsigns'

      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })

      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
      map('n', '<leader>td', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
    end,
  },
}
