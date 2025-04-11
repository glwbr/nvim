local catUtils = require 'utils.cats'

return {
  {
    'rose-pine/neovim',
    enabled = false,
    name = 'rose-pine',
    priority = 1000,
    opts = {
      variant = 'main',
      styles = {
        bold = false,
        italic = false,
        transparency = false,
      },
      highlight_groups = {

        SnacksPicker = { fg = 'subtle', bg = 'NONE' },
        SnacksPickerInput = { fg = 'subtle', bg = 'NONE' },
        SnacksPickerPreview = { fg = 'subtle', bg = 'NONE' },

        BlinkCmpMenu = { bg = 'base' },
        BlinkCmpMenuBorder = { fg = 'foam' },
        BlinkCmpDoc = { bg = 'base' },
        BlinkCmpDocBorder = { fg = 'foam' },
        BlinkCmpSignatureHelp = { bg = 'base' },
        BlinkCmpSignatureHelpBorder = { fg = 'foam' },
        BlinkCmpDocSeparator = { fg = 'foam', bg = 'base' },
        BlinkCmpGhostText = { fg = 'muted' },
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
    opts = {
      background = { light = 'latte', dark = 'mocha' },
      flavour = 'mocha',
      term_colors = true,
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        fidget = true,
        gitsigns = true,
        harpoon = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        snacks = { enabled = true, indent_scope_color = 'mauve' },
        treesitter = true,
      },
      custom_highlights = function(colors)
        return {

          SnacksPicker = { fg = colors.overlay2, bg = 'NONE' },
          SnacksPickerInput = { fg = colors.overlay2, bg = 'NONE' },
          SnacksPickerPreview = { fg = colors.overlay2, bg = 'NONE' },

          BlinkCmpMenu = { bg = colors.base },
          BlinkCmpMenuBorder = { fg = colors.blue },
          BlinkCmpDoc = { bg = colors.base },
          BlinkCmpDocBorder = { fg = colors.blue },
          BlinkCmpSignatureHelp = { bg = colors.base },
          BlinkCmpSignatureHelpBorder = { fg = colors.blue },
          BlinkCmpDocSeparator = { fg = colors.blue, bg = colors.base },
          BlinkCmpGhostText = { fg = colors.overlay2 },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd 'colorscheme catppuccin'
    end,
  },
}
