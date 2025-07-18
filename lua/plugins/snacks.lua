return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    words = { enabled = false },
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        ---@type snacks.dashboard.Item[]
        -- stylua: ignore start
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files({filter = {cwd = true}, layout = 'default'})" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Find Text", action = ":lua Snacks.picker.grep({layout = 'default'})" },
          { icon = " ", key = "b", desc = "File browser", action = function()  require("yazi").yazi(nil, vim.fn.getcwd()) end},
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          -- stylua: ignore end
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1 },
        { title = 'Recent Files', section = 'recent_files', cwd = true },
        { section = 'startup' },
      },
    },
    notifier = { enable = true, margin = { top = 1, right = 1, bottom = 1 }, top_down = false, style = 'compact' },
    quickfile = { enabled = true },
    statuscolumn = { enable = true },
    picker = {
      enabled = true,
      ui_select = true,
      layout = { layout = { backdrop = false } },
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
    { '<leader>/', function() Snacks.picker.grep_buffers() end, desc = ' Fuzzily search in current buffer' },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },
    { '<leader>ff', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
    { '<leader>rf', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
    { '<leader>sb', function() Snacks.picker.buffers() end, desc = '[ ] Find Existing Buffers' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
    { '<leader>sf', function() Snacks.picker.smart() end, desc = '[S]earch [F]iles' },
    { '<leader>sg', function() Snacks.picker.git_grep() end, desc = '[S]earch [/] in Open Files' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp Tags' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eybindings' },
    { '<leader>sp', function() Snacks.picker.projects() end, desc = '[S]earch [P]projects' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = '[S]earch [S] Built-in Pickers' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch Current [W]ord' },
    -- stylua: ignore end
  },
}
