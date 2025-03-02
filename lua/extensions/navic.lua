local M = {}

M.format_data = function()
  local navic = require 'nvim-navic'
  local old_data = navic.get_data()
  local new_data = {}
  local cur_ns = nil
  local ns_comps = {}

  for _, comp in ipairs(old_data) do
    if comp.type == 'Namespace' then
      cur_ns = comp
      table.insert(ns_comps, comp.name)
    else
      if cur_ns ~= nil then
        local num_comps = #ns_comps
        local comb_name = ''
        for idx = 1, num_comps do
          local ns_name = ns_comps[idx]

          local join = (idx == 1) and '' or '::'

          if idx ~= num_comps then
            comb_name = comb_name .. join .. ns_name:sub(1, 1)
          else
            comb_name = comb_name .. join .. ns_name
          end
        end

        cur_ns.name = comb_name
        table.insert(new_data, cur_ns)
        cur_ns = nil
      end

      table.insert(new_data, comp)
    end
  end

  return navic.format_data(new_data)
end

return M
