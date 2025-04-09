local utils = require 'utils'

return {
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    notify_on_error = false,
    log_level = vim.log.levels.DEBUG,
    default_format_opts = {
      timeout_ms = 500,
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
      ['biome-check'] = { append_args = { '--unsafe' } },
      prettierd = { require_cwd = true },
    },
    formatters_by_ft = {
      ['_'] = { 'trim_whitespace' },
      go = { 'goimports', 'gofmt' },
      lua = { 'stylua' },
      nix = { 'nixfmt' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      json = { 'prettierd' },
      jsonc = { 'prettierd' },
      markdown = function(bufnr)
        return { utils.first(bufnr, 'prettierd', 'prettier'), 'injected' }
      end,
    },
  },
}
