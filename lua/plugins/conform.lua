---@param bufnr integer
---@param ... string
---@return string
local first_available = function(bufnr, ...)
  for i = 1, select('#', ...) do
    local formatter = select(i, ...)
    if require('conform').get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
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
      local disabled_filetypes = { c = true, cpp = true, nix = true }
      local filetype = vim.bo[bufnr].filetype

      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat or disabled_filetypes[filetype] then
        return false
      end

      return { lsp_fallback = true }
    end,
    formatters = {
      ['biome-check'] = { append_args = { '--unsafe' } },
      prettierd = { require_cwd = true },
      gofumpt = {
        command = 'gofumpt',
        args = { '-extra', '-w', '$FILENAME' },
        stdin = false,
      },
      yamlfmt = {
        prepend_args = { '-formatter', 'indent=2,include_document_start=true,retain_line_breaks_single=true' },
      },
      --['goimports-reviser'] = { prepend_args = { '-rm-unused' } },
    },

    formatters_by_ft = {
      ['_'] = { 'trim_whitespace' },
      lua = { 'stylua' },
      nix = { 'nixfmt' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      json = { 'prettierd' },
      jsonc = { 'prettierd' },
      go = { 'goimports', 'gofumpt' },
      typst = { 'typstfmt' },
      yaml = { 'yamlfmt' },
      markdown = function(bufnr)
        return { first_available(bufnr, 'prettierd', 'prettier'), 'injected' }
      end,
    },
  },
}
