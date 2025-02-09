local catUtils = require 'utils.cats'

return {
  {
    'rebelot/kanagawa.nvim',
    build = catUtils.ifNotNix ':KanagawaCompile',
    enabled = true,
    opts = {
      compile = catUtils.ifNotNix(true),
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      background = {
        dark = 'wave',
        light = 'lotus',
      },
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd 'colorscheme kanagawa'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = false,
    opts = {
      variant = 'moon',
      styles = {
        bold = true,
        italic = false,
        transparency = true,
      },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)

      vim.cmd 'colorscheme rose-pine'
    end,
  },
}
