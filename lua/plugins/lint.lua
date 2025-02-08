return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      lua = { 'selene' },
      markdown = { 'markdownlint' },
      nix = { 'nix' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    }
  end,
}
