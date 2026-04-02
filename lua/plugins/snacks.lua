return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    words = { enabled = false },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    notifier = { enabled = true, margin = { top = 1, right = 1, bottom = 1 }, top_down = false, style = 'compact' },
    dashboard = {
      enabled = true,
      preset = {
        ---@type snacks.dashboard.Item[]
        -- stylua: ignore start
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.picker.files({filter = {cwd = true}, layout = 'default'})", },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 's', desc = 'Find Text', action = ":lua Snacks.picker.grep({layout = 'default'})" },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          -- stylua: ignore end
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1 },
        { padding = 1 },
        { section = 'recent_files', cwd = true },
        { padding = 1 },
        { section = 'startup' },
      },
    },
    picker = {
      enabled = true,
      ui_select = true,
      layout = {
        preset = 'telescope',
        layout = { backdrop = false },
      },
      win = {
        preview = {
          wo = {
            foldcolumn = '0',
            number = false,
            foldenable = false,
            relativenumber = false,
            fillchars = 'eob: ',
            signcolumn = 'no',
          },
        },
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { '<leader>/',          function() Snacks.picker.grep_buffers() end,   desc = 'Grep Current Buffer' },
    { '<leader><leader>',   function() Snacks.picker.buffers() end,        desc = 'Find Buffers' },
    { '<leader>s.',         function() Snacks.picker.recent() end,         desc = 'Recent Files' },
    { '<leader>sf',         function() Snacks.picker.smart({ filter = { cwd = true } }) end, desc = 'Search Files' },
    { '<leader>sg',         function() Snacks.picker.grep() end,           desc = 'Search Grep' },
    { '<leader>sb',         function() Snacks.picker.buffers() end,        desc = 'Search Buffers' },
    { '<leader>sd',         function() Snacks.picker.diagnostics() end,    desc = 'Search Diagnostics' },
    { '<leader>sh',         function() Snacks.picker.help() end,           desc = 'Search Help' },
    { '<leader>sk',         function() Snacks.picker.keymaps() end,        desc = 'Search Keymaps' },
    { '<leader>sp',         function() Snacks.picker.projects() end,       desc = 'Search Projects' },
    { '<leader>ss',         function() Snacks.picker.pickers() end,        desc = 'Search Pickers' },
    { '<leader>sw',         function() Snacks.picker.grep_word() end,      desc = 'Search Word' },
    { '<leader>rf',         function() Snacks.rename.rename_file() end,    desc = 'Rename File' },
    -- stylua: ignore end
  },
}
