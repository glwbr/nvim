_:
let
  flake = builtins.getEnv "FLAKE";
in
{
  plugins = {
    lsp-format.enable = true;
    lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        silent = true;

        diagnostic = {
          "<leader>cd" = "open_float";
          "[d" = "goto_next";
          "]d" = "goto_prev";
        };

        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "K" = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
          "gi" = "implementation";
          "gt" = "type_definition";
        };
      };

      servers = {
        cssls.enable = true;
        dockerls.enable = true;
        docker_compose_language_service.enable = true;
        # elixirls.enable = true;
        eslint.enable = true;
        gopls.enable = true;
        html.enable = true;
        # htmx.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        marksman.enable = true;
        nginx_language_server.enable = true;
        nixd = {
          enable = true;
          extraOptions.settings = {
            nixd = {
              nixpkgs.expr = ''import (builtins.getFlake "${flake}").inputs.nixpkgs { }'';
              options = {
                nixos.expr = ''(builtins.getFlake "${flake}").nixosConfigurations.sonata.options'';
                home_manager.expr = ''(builtins.getFlake "${flake}").homeConfigurations.sonta.options'';
              };
              flake_parts.expr = ''let flake = builtins.getFlake ("${flake}"); in flake.debug.options // flake.currentSystem.options'';
            };
          };
        };
        phpactor.enable = true;
        ruff.enable = true;
        templ.enable = true;
        ts_ls = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
            "vue"
          ];
          settings = {
            init_options = {
              plugins = {
                name = "@vue/typescript-plugin";
                languages = [
                  "javascript"
                  "typescript"
                  "vue"
                ];
                location = "arbitrary_location";
              };
            };
            typescript = {
              inlayHints = {
                enumMemberValues.enabled = true;
                functionLikeReturnTypes.enabled = true;
                parameterNames.enabled = "literals";
                parameterTypes.enabled = true;
                propertyDeclarationTypes.enabled = true;
                variableType.enabled = false;
              };

              updateImportsOnFileMove.enabled = "always";
              suggest.completeFunctionCalls = true;
            };
          };
        };
        volar.enable = true;
        yamlls = {
          enable = true;
          extraOptions.settings.yaml = {
            schemas = {
              kubernetes = "'*.yaml";
              "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
              "http://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
              "http://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
              "https://json.schemastore.org/dependabot-v2" = ".github/dependabot.{yml,yaml}";
              "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = "*docker-compose*.{yml,yaml}";
              "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" = "*flow*.{yml,yaml}";
            };
          };
        };
      };
    };
  };

  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config {
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
}
