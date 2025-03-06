local utils = require 'utils'
local extensions = require 'extensions.harpoon'
local map = utils.map

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    }

    for i = 1, 5 do
      vim.keymap.set('n', '<C-' .. i .. '>', function()
        require('harpoon'):list():select(i)
      end, { desc = 'Goto Harpoon File ' .. i })
    end

    map('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add File to Harpoon List' })

    map('n', '<C-e>', function()
      extensions.toggle_picker(harpoon:list())
    end, { desc = 'Open Harpoon Quick Menu' })
  end,
}
