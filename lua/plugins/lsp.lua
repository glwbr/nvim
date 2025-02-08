local utils = require 'utils'
local cats = require 'utils.cats'
local map = utils.map

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      enabled = cats.ifNotNix(true),
      config = true,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      enabled = cats.ifNotNix(true),
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      enabled = cats.ifNotNix(true),
    },
    { 'j-hui/fidget.nvim', opts = {} },
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = (nixCats.nixCatsPath or '') .. '/lua', words = { 'nixCats' } },
        },
      },
    },
  },
  opts = function()
    return {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'nixCats' },
                disable = { 'missing-fields' },
              },
            },
          },
        },
        gopls = {},
        ts_ls = {},
        nixd = {},
      },
    }
  end,
  config = function(_, opts)
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require 'lspconfig'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        map('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
        map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
        map('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = '[G]oto [D]efinition' })
        map('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
        map('n', 'gI', require('telescope.builtin').lsp_implementations, { desc = '[G]oto [I]mplementation' })
        map('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, { desc = 'Type [D]efinition' })
        map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
        map(
          'n',
          '<leader>ws',
          require('telescope.builtin').lsp_dynamic_workspace_symbols,
          { desc = '[W]orkspace [S]ymbols' }
        )
        map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
        map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { desc = '[T]oggle Inlay [H]ints' })
        end

        if client.server_capabilities.documentHighlightProvider then
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

    if cats.isNixCats then
      for server, config in pairs(opts.servers) do
        lspconfig[server].setup {
          capabilities = capabilities,
          settings = config.settings,
          filetypes = config.filetypes,
          cmd = config.cmd,
          root_pattern = config.root_pattern,
        }
      end
    else
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(opts.servers or {})
      vim.list_extend(ensure_installed, { 'stylua' })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        automatic_installation = cats.ifNotNix(true),
        handlers = {
          function(server_name)
            local server = opts.servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            lspconfig[server_name].setup(server)
          end,
        },
      }
    end
  end,
}
