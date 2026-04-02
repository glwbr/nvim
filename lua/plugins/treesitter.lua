return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {}

    require('nvim-treesitter').install {
      'bash',
      'c',
      'css',
      'diff',
      'dockerfile',
      'go',
      'html',
      'javascript',
      'json',
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
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = args.match
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if pcall(vim.treesitter.language.inspect, lang) then
          vim.treesitter.start(args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
