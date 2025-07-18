local map = require('utils').map
local catUtils = require 'utils.cats'

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
    local root_pattern = require('lspconfig.util').root_pattern
    return {
      servers = {
        cssls = {},
        dockerls = {},
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          staticcheck = true,
          semanticTokens = true,
          directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = false,
            },
          },
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
        html = {},
        jsonls = {},
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
        nixd = {},
        tailwindcss = {
          root_dir = root_pattern(
            'tailwind.config.js',
            'tailwind.config.cjs',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.ts'
          ),
          settings = {
            scss = { validate = false },
            editor = { quickSuggestions = { strings = true }, autoClosingQuotes = 'always' },
            tailwindCSS = {
              experimental = {
                classRegex = {
                  [[[\S]*ClassName="([^"]*)]], -- <MyComponent containerClassName="..." />
                  [[[\S]*ClassName={"([^"}]*)]], -- <MyComponent containerClassName={"..."} />
                  [[[\S]*ClassName={"([^'}]*)]], -- <MyComponent containerClassName={'...'} />
                },
              },
              includeLanguages = {
                typescript = 'javascript',
                typescriptreact = 'javascript',
              },
            },
          },
        },
        vtsls = {
          settings = {
            separate_diagnostic_server = true,
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = { completeFunctionCalls = true },
              tsserver = {
                maxTsServerMemory = 5120,
              },
            },
          },
        },
        yamlls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              schemaStore = {
                enable = true,
                url = 'https://www.schemastore.org/api/json/catalog.json',
              },
              format = { enabled = false },
              -- enabling this conflicts between Kubernetes resources, kustomization.yaml, and Helmreleases
              validate = false,
              schemas = {
                kubernetes = '*.yaml',
                ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
                ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
                ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] = 'azure-pipelines*.{yml,yaml}',
                ['https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks'] = 'roles/tasks/*.{yml,yaml}',
                ['https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook'] = '*play*.{yml,yaml}',
                ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
                ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
                ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
                ['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
                ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '*gitlab-ci*.{yml,yaml}',
                ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
                ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
              },
            },
          },
        },
      },

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

        map('n', '<leader>ds', Snacks.picker.lsp_symbols, { desc = '[L]sp [D]ocument Symbols' })
        map('n', '<leader>ws', Snacks.picker.lsp_workspace_symbols, { desc = '[L]sp [W]orkspace Symbols' })

        map('n', 'ca', vim.lsp.buf.code_action, { desc = 'Code Actions' })
        map('n', 'gr', Snacks.picker.lsp_references, { desc = 'Goto References' })
        map('n', 'gd', Snacks.picker.lsp_definitions, { desc = 'Goto Definition' })
        map('n', 'gt', Snacks.picker.lsp_type_definitions, { desc = 'Goto Type Definition' })
        map('n', 'gi', Snacks.picker.lsp_implementations, { desc = 'Goto Implementation' })

        map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
        map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
        map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[L]sp [R]ename' })

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) and vim.lsp.inlay_hint then
          map('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { desc = '[L]sp [T]oggle [H]ints' })
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

    local lspconfig = require 'lspconfig'

    if catUtils.isNixCats then
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
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
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
          end,
        },
      }
    end
  end,
}
