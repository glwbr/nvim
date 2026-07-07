return {
  'nvim-treesitter/nvim-treesitter',
  -- The `main` branch is the current, Neovim 0.11+/0.12-native rewrite. It
  -- dropped the classic `nvim-treesitter.configs` module and the `.setup()`
  -- highlight/indent modules; parsers are installed explicitly and highlight
  -- is started per-buffer. Requires the `tree-sitter` CLI (>= 0.26.1) on PATH.
  branch = 'main',
  lazy = false, -- main branch does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- Parsers to keep installed. install() is async and idempotent, so it
    -- only fetches/compiles the grammars that are missing.
    ts.install {
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
      'nix',
      'regex',
      'toml',
      'terraform',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    }

    -- `jsonc` is not its own parser on the main branch; reuse the json parser.
    vim.treesitter.language.register('json', 'jsonc')

    -- main no longer wires the highlight/indent modules for you: start
    -- treesitter per-buffer whenever a parser is available. Folding is enabled
    -- globally via foldexpr in lua/glwbr/opts.lua.
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('glwbr.treesitter', { clear = true }),
      callback = function(ev)
        -- vim.treesitter.start() derives the language from filetype and errors
        -- if no parser is installed; pcall keeps non-treesitter buffers quiet.
        if not pcall(vim.treesitter.start, ev.buf) then
          return
        end
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
