local map = require('utils').map

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
      map('n', '<leader>' .. i, function()
        require('harpoon'):list():select(i)
      end, { desc = 'Goto Harpoon File ' .. i })
    end

    map('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Add File to Harpoon List' })

    map('n', '<leader>e', function()
      local harpoon_files = harpoon:list()
      local function generate_items()
        local items = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(items, {
            text = item.value,
            file = item.value,
          })
        end
        return items
      end

      Snacks.picker {
        finder = generate_items,
        title = 'Harpoon',
        layout = { preset = 'vscode' },
        win = {
          input = {
            keys = {
              ['<C-x>'] = { 'delete', mode = { 'i' } },
              ['dd'] = { 'delete', mode = { 'n', 'v' } },
            },
          },
        },
        actions = {
          delete = function(picker, item)
            if item.idx then
              table.remove(harpoon_files.items, item.idx)
              picker:find { refresh = true }
            end
          end,
        },
      }
    end, { desc = 'Open Harpoon Quick Menu' })
  end,
}
