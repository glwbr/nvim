local M = {}

M.toggle_picker = function(harpoon_files)
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

  return Snacks.picker {
    finder = generate_items,
    title = 'Harpoon',
    layout = { preset = 'vscode' },
    win = {
      input = {
        keys = {
          ['<C-x>'] = { 'delete', mode = { 'i' } },
          ['<C-e>'] = { 'close', mode = { 'i', 'v' } },
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
      close = function(picker)
        picker:close()
      end,
    },
  }
end

return M
