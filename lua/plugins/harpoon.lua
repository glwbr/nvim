local utils = require 'utils'
local extensions = require 'extensions.harpoon'
local map = utils.map

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {}

    map('n', '<leader>a', function()
      harpoon:list():add()
    end)

    map('n', '<C-e>', function()
      extensions.toggle_telescope(harpoon:list())
    end, { desc = 'Harpoon Quick Menu' })

    map('n', '<C-1>', function()
      harpoon:list():select(1)
    end, { desc = 'Goto Harpoon File 1' })

    map('n', '<C-2>', function()
      harpoon:list():select(2)
    end, { desc = 'Goto Harpoon File 2' })

    map('n', '<C-3>', function()
      harpoon:list():select(3)
    end, { desc = 'Goto Harpoon File 3' })

    map('n', '<C-4>', function()
      harpoon:list():select(4)
    end, { desc = 'Goto Harpoon File 4' })

    map('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)

    map('n', '<C-S-N>', function()
      harpoon:list():next()
    end)
  end,
}
