local catUtils = require 'utils.cats'

return {
  'nvim-treesitter/nvim-treesitter',
  build = catUtils.ifNotNix ':TSUpdate',
  opts = {
    ensure_installed = catUtils.ifNotNix {
      'bash',
      'c',
      'css',
      'diff',
      'dockerfile',
      'go',
      'html',
      'javascript',
      'json',
      'jsonc',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'regex',
      'toml',
      'terraform',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
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
