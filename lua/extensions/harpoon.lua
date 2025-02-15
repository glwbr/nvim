local M = {}

M.toggle_telescope = function(harpoon_files)
  local telescope = require 'telescope.config'
  local finders = require 'telescope.finders'

  local finder = function()
    local paths = {}

    for _, item in ipairs(harpoon_files.items) do
      table.insert(paths, item.value)
    end

    return finders.new_table { results = paths }
  end

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Harpoon',
      finder = finder(),
      sorter = telescope.values.generic_sorter {},
      layout_config = {
        height = 0.4,
        width = 0.5,
      },
      attach_mappings = function(prompt_bufnr, map)
        map('n', 'dd', function()
          local state = require 'telescope.actions.state'
          local selected_entry = state.get_selected_entry()
          local current_picker = state.get_current_picker(prompt_bufnr)

          table.remove(harpoon_files.items, selected_entry.index)
          current_picker:refresh(finder())
        end)
        return true
      end,
    })
    :find()
end

return M
