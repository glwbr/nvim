local utils = require 'utils'
local map = utils.map

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    ---@type snacks.Config
    require('snacks').setup {
      words = { enabled = true },
      bigfile = { enabled = true },
      scratch = { enabled = false },
      statuscolumn = { enabled = true },
      picker = {
        layout = function()
          return vim.o.columns >= 120 and 'my_telescope'
            or vim.o.lines >= 25 and 'my_telescope_vertical'
            or 'my_telescope_vertical_no_preview'
        end,
        matcher = { frecency = true },
        ui_select = true,
        previewers = { git = { native = true } },
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = {
            hidden = true,
          },
          select = { layout = { preset = 'my_select' } },
        },
        layouts = {
          my_telescope = {
            reverse = true,
            layout = {
              box = 'horizontal',
              backdrop = false,
              width = 0.7,
              height = 0.8,
              border = 'none',
              {
                box = 'vertical',
                { win = 'list', title = ' Results ', title_pos = 'center', border = 'solid' },
                { win = 'input', height = 1, border = 'solid', title = '{title} {live} {flags}', title_pos = 'center' },
              },
              {
                win = 'preview',
                title = '{preview:Preview}',
                width = 0.45,
                border = 'solid',
                title_pos = 'center',
              },
            },
          },
          my_telescope_vertical = {
            reverse = true,
            layout = {
              box = 'vertical',
              backdrop = false,
              width = 0.7,
              height = 0.8,
              border = 'none',
              {
                win = 'preview',
                title = '{preview:Preview}',
                height = 0.4,
                border = 'solid',
                title_pos = 'center',
              },
              { win = 'list', title = ' Results ', title_pos = 'center', border = 'solid' },
              { win = 'input', height = 1, border = 'solid', title = '{title} {live} {flags}', title_pos = 'center' },
            },
          },
          my_telescope_vertical_no_preview = {
            reverse = true,
            layout = {
              box = 'vertical',
              backdrop = false,
              width = 0.7,
              height = 0.8,
              border = 'none',
              { win = 'list', title = ' Results ', title_pos = 'center', border = 'solid' },
              { win = 'input', height = 1, border = 'solid', title = '{title} {live} {flags}', title_pos = 'center' },
            },
          },
          my_select = {
            layout = {
              backdrop = false,
              width = 0.5,
              min_width = 80,
              height = 0.4,
              min_height = 1,
              border = 'top',
              title = '{title}',
              box = 'vertical',
              {
                box = 'vertical',
                border = 'bottom',
                height = 1,
                { win = 'input', title = '{title}', height = 1, border = 'hpad' },
              },
              { win = 'list', border = 'none' },
            },
          },
        },
        win = {
          input = { keys = { ['<Esc>'] = { 'close', mode = { 'n', 'i' } } } },
          preview = { wo = { foldcolumn = '0', number = false, relativenumber = false, signcolumn = 'no' } },
        },
        debug = { scores = false },
      },
    }

    map('n', '<leader>/', Snacks.picker.grep_buffers, { desc = '[/] Fuzzily search in current buffer' })
    map('n', '<leader>s.', Snacks.picker.recent, { desc = '[S]earch Recent Files ("." for repeat)' })
    map('n', '<leader>ff', Snacks.picker.files, { desc = '[S]earch [F]iles' })
    map('n', '<leader>rf', Snacks.rename.rename_file, { desc = 'Rename File' })
    map('n', '<leader>sd', Snacks.picker.diagnostics, { desc = '[S]earch [D]iagnostics' })
    map('n', '<leader>sf', Snacks.picker.smart, { desc = '[S]earch [F]iles' })
    map('n', '<leader>sg', Snacks.picker.git_grep, { desc = '[S]earch [/] in Open Files' })
    map('n', '<leader>sh', Snacks.picker.help, { desc = '[S]earch [H]elp Tags' })
    map('n', '<leader>sk', Snacks.picker.keymaps, { desc = '[S]earch [K]eybindings' })
    map('n', '<leader>sn', function()
      Snacks.picker.files { cwd = vim.fn.stdpath 'config', title = 'Neovim Files' }
    end, { desc = '[S]earch [N]eovim Config Files' })
    map('n', '<leader>sp', Snacks.picker.projects, { desc = '[S]earch [P]projects' })
    map('n', '<leader>ss', Snacks.picker.pickers, { desc = '[S]earch [S] Built-in Pickers' })
    map('n', '<leader>sw', Snacks.picker.grep_word, { desc = '[S]earch Current [W]ord' })
    map('n', '<leader><leader>', Snacks.picker.buffers, { desc = '[ ] Find Existing Buffers' })
  end,
}
