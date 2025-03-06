return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      go = { 'golangcilint' },
      dockerfile = { 'dockerfile' },
    }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePre', 'InsertLeave', 'TextChanged' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
