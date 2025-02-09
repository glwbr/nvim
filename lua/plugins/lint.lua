return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
    }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePre', 'InsertLeave', 'TextChanged' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
