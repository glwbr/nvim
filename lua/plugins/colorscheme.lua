local catUtils = require 'utils.cats'

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = false,
    opts = {
      variant = 'main',
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd 'colorscheme rose-pine'
    end,
  },
  {
    'catppuccin/nvim',
    enabled = true,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        background = {
          light = 'latte',
          dark = 'mocha',
        },
        flavour = 'mocha',
        integrations = {
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
          },
        },
        styles = {
          comments = { 'italic' },
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        term_colors = true,
      }
      vim.cmd 'colorscheme catppuccin'
    end,
  },
}
