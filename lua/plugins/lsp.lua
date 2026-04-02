local map = require('utils').map

local servers = {
  'cssls',
  'dockerls',
  'gopls',
  'html',
  'jsonls',
  'lua_ls',
  'nixd',
  'tailwindcss',
  'vtsls',
  'yamlls',
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = {
        ensure_installed = {
          -- LSP servers
          'css-lsp',
          'dockerfile-language-server',
          'gopls',
          'html-lsp',
          'json-lsp',
          'lua-language-server',
          'tailwindcss-language-server',
          'vtsls',
          'yaml-language-server',
          -- Formatters
          'stylua',
          'prettierd',
          'goimports',
          'gofumpt',
          'nixfmt',
          'yamlfmt',
          -- Linters
          'golangci-lint',
          'hadolint',
          'eslint_d',
          'yamllint',
        },
      },
    },
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      cmd = 'LazyDev',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          { path = 'snacks.nvim', words = { 'Snacks' } },
        },
      },
    },
  },
  config = function()
    vim.diagnostic.config {
      underline = true,
      virtual_text = false,
      severity_sort = true,
      update_in_insert = false,
      signs = {
        text = {
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.ERROR] = '',
        },
        numhl = {
          [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
          [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
          [vim.diagnostic.severity.WARN] = 'WarningMsg',
          [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
      },
      float = {
        source = 'if_many',
        border = 'rounded',
        style = 'minimal',
        focusable = true,
        header = '',
        prefix = '',
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        map('n', '<leader>ds', function()
          Snacks.picker.lsp_symbols()
        end, { desc = 'Document Symbols', buffer = event.buf })
        map('n', '<leader>ws', function()
          Snacks.picker.lsp_workspace_symbols()
        end, { desc = 'Workspace Symbols', buffer = event.buf })

        map('n', 'ca', vim.lsp.buf.code_action, { desc = 'Code Actions', buffer = event.buf })
        map('n', 'gr', function()
          Snacks.picker.lsp_references()
        end, { desc = 'Goto References', buffer = event.buf })
        map('n', 'gd', function()
          Snacks.picker.lsp_definitions()
        end, { desc = 'Goto Definition', buffer = event.buf })
        map('n', 'gt', function()
          Snacks.picker.lsp_type_definitions()
        end, { desc = 'Goto Type Definition', buffer = event.buf })
        map('n', 'gi', function()
          Snacks.picker.lsp_implementations()
        end, { desc = 'Goto Implementation', buffer = event.buf })

        map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation', buffer = event.buf })
        map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration', buffer = event.buf })
        map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename', buffer = event.buf })

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) and vim.lsp.inlay_hint then
          map('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { desc = 'Toggle Inlay Hints', buffer = event.buf })
        end

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(detach_event)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = detach_event.buf }
            end,
          })
        end
      end,
    })

    vim.lsp.enable(servers)
  end,
}
