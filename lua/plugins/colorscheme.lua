local utils = require 'utils'
local catUtils = require 'utils.cats'

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    opts = {
      variant = 'auto',
      dark_variant = 'moon',
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      styles = { bold = true, italic = false, transparency = false },
      enable = { terminal = true, legacy_highlights = true, migrations = true },
      highlight_groups = {
        Pmenu = { bg = 'surface' },
        PmenuSbar = { bg = 'surface' },

        BlinkCmpMenu = { bg = 'base' },
        BlinkCmpMenuBorder = { fg = 'muted' },
        BlinkCmpMenuSelection = { link = 'PmenuSel', bold = true },
        BlinkCmpScrollBarThumb = { bg = 'overlay' },
        BlinkCmpScrollBarGutter = { bg = 'surface' },
        BlinkCmpLabel = { fg = 'text' },
        BlinkCmpLabelDeprecated = { fg = 'love', strikethrough = true },
        BlinkCmpLabelMatch = { fg = 'NONE', bg = 'NONE', bold = true },
        BlinkCmpLabelDetail = { fg = 'subtle' },
        BlinkCmpLabelDescription = { fg = 'subtle' },
        BlinkCmpSource = { fg = 'muted' },
        BlinkCmpGhostText = { fg = 'muted' },
        BlinkCmpDoc = { bg = 'base' },
        BlinkCmpDocBorder = { fg = 'muted' },
        BlinkCmpDocSeparator = { fg = 'overlay' },
        BlinkCmpDocCursorLine = { bg = 'surface' },
        BlinkCmpSignatureHelp = { bg = 'base' },
        BlinkCmpSignatureHelpBorder = { fg = 'muted' },
        BlinkCmpSignatureHelpActiveParameter = { fg = 'foam', bold = true },

        ['@keyword.export'] = { fg = 'pine' },
      },
      before_highlight = function(group, hl, p)
        local bit_lighter_than_bg = utils.lighten_color(p.base, 2)
        if group == 'CursorLine' or group == 'ColorColumn' then
          hl.bg = bit_lighter_than_bg
        end
      end,
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    -- 'thesimonho/kanagawa-paper.nvim',
    -- name = 'kanagawa-paper',
    priority = 1000,
    lazy = false,
    opts = {
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = {},
      statementStyle = {},
      cache = catUtils.ifNotNix(true),
      dim_inactive = true,
      colors = {
        palette = { winterYellow = '#302e30' },
        theme = {
          all = { ui = { bg_gutter = 'none', bg = '#1b1b23' } },
          -- ink = { ui = { bg = '#1b1b23' } },
        },
      },
      overrides = function(colors)
        ---@type ThemeColors
        local theme = colors.theme
        local bit_lighter_than_bg = utils.lighten_color(theme.ui.bg, 2)
        return {
          CursorLine = { bg = bit_lighter_than_bg },
          ColorColumn = { bg = bit_lighter_than_bg },

          Pmenu = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p1 },
          PmenuSbar = { bg = theme.ui.bg_p1 },
          PmenuSel = { fg = theme.ui.bg, bg = theme.ui.special },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          BlinkCmpMenu = { bg = theme.ui.bg },
          BlinkCmpMenuBorder = { fg = theme.ui.nontext },
          BlinkCmpMenuSelection = { link = 'PmenuSel', bold = true },
          BlinkCmpScrollBarThumb = { bg = theme.ui.bg_p2 },
          BlinkCmpScrollBarGutter = { bg = theme.ui.bg_p1 },
          BlinkCmpLabel = { fg = theme.ui.fg },
          BlinkCmpLabelDeprecated = { fg = theme.syn.keyword, strikethrough = true },
          BlinkCmpLabelMatch = { bg = 'NONE', fg = 'NONE', bold = true },
          BlinkCmpLabelDetail = { fg = theme.ui.fg_dim },
          BlinkCmpLabelDescription = { fg = theme.ui.fg_dim },
          BlinkCmpSource = { fg = theme.ui.nontext },
          BlinkCmpGhostText = { fg = theme.ui.nontext },
          BlinkCmpDoc = { bg = theme.ui.bg },
          BlinkCmpDocBorder = { fg = theme.ui.nontext },
          BlinkCmpDocSeparator = { fg = theme.ui.bg_p2 },
          BlinkCmpDocCursorLine = { bg = theme.ui.bg_p1 },
          BlinkCmpSignatureHelp = { bg = theme.ui.bg },
          BlinkCmpSignatureHelpBorder = { fg = theme.ui.nontext },
          BlinkCmpSignatureHelpActiveParameter = { fg = theme.syn.fun, bold = true },

          Folded = { bg = bit_lighter_than_bg },
          FloatBorder = { fg = theme.ui.float.bg, bg = theme.ui.float.bg },
          Winbar = { fg = theme.syn.fun },

          Directory = { fg = theme.syn.comment, italic = true },
          GitSignsAddInline = { fg = theme.ui.float.bg, bg = theme.syn.string },

          DiagnosticFloatingError = { fg = theme.diag.error, bg = 'NONE' },
          DiagnosticFloatingWarn = { fg = theme.diag.warning, bg = 'NONE' },
          DiagnosticFloatingInfo = { fg = theme.diag.info, bg = 'NONE' },
          DiagnosticFloatingHint = { fg = theme.diag.hint, bg = 'NONE' },
          DiagnosticFloatingOk = { fg = theme.diag.ok, bg = 'NONE' },
          DiagnosticUnderlineWarn = { sp = theme.diag.warning, undercurl = true },
          DiagnosticUnderlineError = { sp = theme.diag.error, undercurl = true },

          LspReferenceWrite = { underline = false },
          StatuslineError = { fg = theme.diag.error, bg = theme.ui.bg_m3 },
          StatuslineWarning = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },
          StatuslineBoolean = { fg = theme.diag.warning, bg = theme.ui.bg_m3 },

          ['@keyword.export'] = { fg = theme.syn.preproc },
          OilDir = { fg = theme.syn.fun, italic = false },
        }
      end,
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      -- vim.cmd.colorscheme 'kanagawa'
    end,
  },
}
