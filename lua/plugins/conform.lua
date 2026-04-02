return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>tf',
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        Snacks.notify(
          'Format on save: ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'),
          { level = vim.g.disable_autoformat and 'warn' or 'info' }
        )
      end,
      desc = 'Toggle Format on Save',
    },
  },
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
      ['biome-check'] = {
        require_cwd = true,
        append_args = { '--unsafe' },
      },
      prettierd = { require_cwd = true },
      gofumpt = {
        command = 'gofumpt',
        args = { '-extra', '-w', '$FILENAME' },
        stdin = false,
      },
      yamlfmt = {
        prepend_args = { '-formatter', 'indent=2,include_document_start=true,retain_line_breaks_single=true' },
      },
    },

    formatters_by_ft = {
      ['_'] = { 'trim_whitespace' },
      lua = { 'stylua' },
      nix = { 'nixfmt' },
      javascript = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      json = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
      go = { 'goimports', 'gofumpt' },
      yaml = { 'yamlfmt' },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
