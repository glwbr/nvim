local utils = require 'utils'
local catUtils = require 'utils.cats'
local map = utils.map

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', enabled = catUtils.ifNotNix(true), opts = {} },
    { 'williamboman/mason-lspconfig.nvim', enabled = catUtils.ifNotNix(true) },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', enabled = catUtils.ifNotNix(true) },
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      cmd = 'LazyDev',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          { path = (nixCats.nixCatsPath or '') .. '/lua', words = { 'nixCats' } },
        },
      },
    },
  },
  opts = function()
    return {
      servers = {
        dockerls = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = 'Replace',
              },
              codeLens = {
                enable = true,
              },
              doc = {
                privateName = { '^_' },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
              },
              diagnostics = {
                disable = { 'missing-fields' },
              },
            },
          },
        },
        gopls = {},
        ts_ls = {},
        nixd = {},
      },

      vim.diagnostic.config {
        virtual_text = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'none',
          source = true,
          header = '',
          prefix = '',
        },
      },
    }
  end,
  config = function(_, opts)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
        map('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition' })
        map('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
        map('n', 'gi', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation' })
        map('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
        map('n', 'gt', require('telescope.builtin').lsp_type_definitions, { desc = '[G]oto [T]ype' })
        map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
        map(
          'n',
          '<leader>ws',
          require('telescope.builtin').lsp_dynamic_workspace_symbols,
          { desc = '[W]orkspace [S]ymbols' }
        )
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
        map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })

        if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) and vim.lsp.inlay_hint then
          map('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { desc = '[T]oggle Inlay [H]ints' })
        end

        if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

    local lspconfig = require 'lspconfig'

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
      end
    end

    if catUtils.isNixCats then
      for server, config in pairs(opts.servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        config.on_attach = on_attach
        lspconfig[server].setup(config)
      end
    else
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(opts.servers or {})
      vim.list_extend(ensure_installed, { 'stylua' })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        automatic_installation = catUtils.ifNotNix(true),
        handlers = {
          function(server)
            local config = opts.servers[server] or {}
            config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
            config.on_attach = on_attach
            lspconfig[server].setup(config)
          end,
        },
      }
    end
  end,
}
