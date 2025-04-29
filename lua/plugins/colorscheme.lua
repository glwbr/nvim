-- local catUtils = require 'utils.cats'

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
      variant = 'auto',
      dark_variant = 'main',
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },

      styles = {
        bold = true,
        italic = false,
        transparency = true,
      },

      highlight_groups = {
        ColorColumn = { bg = 'highlight_low' },

        SnacksPicker = { fg = 'subtle', bg = 'NONE' },
        SnacksPickerInput = { fg = 'subtle', bg = 'NONE' },
        SnacksPickerPreview = { fg = 'subtle', bg = 'NONE' },

        BlinkCmpMenu = { bg = 'NONE' },
        BlinkCmpMenuBorder = { fg = 'muted' },
        BlinkCmpDoc = { bg = 'NONE' },
        BlinkCmpDocBorder = { fg = 'muted' },
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
}
