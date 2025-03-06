return {
  'Bekaboo/dropbar.nvim',
  enabled = false,
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  config = function()
    require('dropbar').setup {
      sources = {
        path = {
          max_depth = 3,
        },
      },
    }
  end,
}
