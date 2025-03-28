local catUtils = require 'utils.cats'

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = true,
    opts = {
      variant = 'main',
      styles = {
        bold = false,
        italic = false,
        transparency = false,
      },
      highlight_groups = {
        SnacksPicker = { fg = 'subtle', bg = 'base' },
        SnacksPickerTitle = { fg = 'base', bg = 'foam' },
        SnacksPickerBorder = { fg = 'base', bg = 'base' },
        SnacksPickerPreviewVisual = { fg = 'subtle', bg = 'love' },
        SnacksPickerInput = { fg = 'subtle', bg = 'base' },
        SnacksPickerInputTitle = { fg = 'foam', bg = 'base' },
        SnacksPickerInputBorder = { fg = 'base', bg = 'base' },
        SnacksPickerPreview = { fg = 'subtle', bg = 'surface' },
        SnacksPickerPreviewTitle = { fg = 'surface', bg = 'iris' },
        SnacksPickerPreviewBorder = { fg = 'surface', bg = 'surface' },
        SnacksPickerBoxTitle = { fg = 'base', bg = 'gold' },
        SnacksPickerBoxBorder = { fg = 'base', bg = 'base' },

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
    enabled = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        background = { light = 'latte', dark = 'mocha' },
        flavour = 'mocha',
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
          telescope = true,
          treesitter = true,
        },
        custom_highlights = function(colors)
          return {
            SnacksPicker = { fg = colors.overlay2, bg = colors.mantle },
            SnacksPickerTitle = { fg = colors.mantle, bg = colors.blue },
            SnacksPickerBorder = { fg = colors.mantle, bg = colors.mantle },
            SnacksPickerPreviewVisual = { fg = colors.overlay2, bg = colors.red },
            SnacksPickerInput = { fg = colors.overlay2, bg = colors.mantle },
            SnacksPickerInputTitle = { fg = colors.mantle, bg = colors.peach },
            SnacksPickerInputBorder = { fg = colors.mantle, bg = colors.mantle },
            SnacksPickerPreview = { fg = colors.overlay2, bg = colors.crust },
            SnacksPickerPreviewTitle = { fg = colors.crust, bg = colors.mauve },
            SnacksPickerPreviewBorder = { fg = colors.crust, bg = colors.crust },
            SnacksPickerBoxTitle = { fg = colors.mantle, bg = colors.peach },
            SnacksPickerBoxBorder = { fg = colors.mantle, bg = colors.mantle },

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
