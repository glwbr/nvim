local utils = require 'utils'

return {
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    notify_on_error = false,
    default_format_opts = {
      timeout_ms = 1000,
      async = false,
      quiet = false,
      lsp_format = 'fallback',
    },
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      return {
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      nix = { 'nixfmt' },
      typescriptreact = { 'eslint_d', 'prettierd' },
      javascriptreact = { 'eslint_d', 'prettierd' },
      markdown = function(bufnr)
        return { utils.first(bufnr, 'prettierd', 'prettier'), 'injected' }
      end,
    },
  },
}
