local utils = require 'utils'

return {
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    notify_on_error = false,
    log_level = vim.log.levels.DEBUG,
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
    formatters = {
      prettier = {
        require_cwd = true,
      },
    },
    formatters_by_ft = {
      ['_'] = { 'trim_whitespace' },
      lua = { 'stylua' },
      nix = { 'nixfmt' },
      json = { 'jq' },
      jsonc = { 'jq' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      markdown = function(bufnr)
        return { utils.first(bufnr, 'prettierd', 'prettier'), 'injected' }
      end,
    },
  },
}
