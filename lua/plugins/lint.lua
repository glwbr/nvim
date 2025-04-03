return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      go = { 'golangcilint' },
      dockerfile = { 'hadolint' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePre', 'InsertLeave', 'TextChanged' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
