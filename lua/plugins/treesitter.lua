local catUtils = require 'utils.cats'

return {
  'nvim-treesitter/nvim-treesitter',
  build = catUtils.ifNotNix ':TSUpdate',
  opts = {
    ensure_installed = catUtils.ifNotNix {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'vim',
      'vimdoc',
    },
    auto_install = catUtils.ifNotNix(true),
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.configs').setup(opts)
  end,
}
