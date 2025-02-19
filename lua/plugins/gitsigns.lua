local utils = require 'utils'
local catUtils = require 'utils.cats'

local map = utils.map

return {
  'lewis6991/gitsigns.nvim',
  enabled = catUtils.enableForCategory 'qualityOfLife',
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
    current_line_blame_formatter = '<author> • <author_time:%R> <summary>',
    current_line_blame_formatter_nc = 'Uncommitted changes',
    preview_config = {
      border = 'none',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
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
      end, { desc = 'Jump to next git change' })

      map('n', 'gk', function()
        if vim.wo.diff then
          vim.cmd.normal { 'gk', bang = true }
        else
          gs.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git change' })

      map('n', '<leader>gb', gs.blame_line, { desc = 'Blame line' })
      map('n', '<leader>gD', gs.diffthis, { desc = 'Diff' })
      map('n', '<leader>gp', gs.preview_hunk_inline, { desc = 'Preview changes' })
      map('v', '<leader>gs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Stage selected hunk' })
      map('v', '<leader>gu', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Undo staged hunk' })
    end,
  },
}
