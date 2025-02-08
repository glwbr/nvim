local utils = require 'utils.cats'

return {
  'nvim-treesitter/nvim-treesitter',
  build = utils.ifNotNix ':TSUpdate',
  opts = {
    ensure_installed = utils.ifNotNix {
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
    auto_install = utils.ifNotNix(true),
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
