return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    config = function()
      ---@module 'oil'
      ---@type oil.SetupOpts
      require('oil').setup {
        skip_confirm_for_simple_edits = true,
        view_options = { show_hidden = true },
      }
    end,
  },
}
