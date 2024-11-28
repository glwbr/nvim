{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.plugins;
  lsp = config.plugins.lsp.servers;
in
{
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      keymaps = {
        silent = true;

        diagnostic = {
          "cd" = "open_float";
          "[d" = "goto_next";
          "]d" = "goto_prev";
        };

        lspBuf = {
          "ca" = {
            action = "code_action";
            desc = "[C]ode [A]ction";
          };
          "<leader>rn" = {
            action = "rename";
            desc = "Rename";
          };
          gd = {
            action = "definition";
            desc = "[G]oto [D]efinition";
          };
          gD = {
            action = "declaration";
            desc = "[G]oto [D]eclaration";
          };
          gi = {
            action = "implementation";
            desc = "[G]oto [I]mplementation";
          };
          gr = {
            action = "references";
            desc = "[G]oto [R]eferences";
          };
          gt = {
            action = "type_definition";
            desc = "[G]oto [T]ype Definition";
          };
        };
      };

      servers = {
        cssls.enable = true;
        dockerls.enable = true;
        docker_compose_language_service.enable = true;
        # elixirls.enable = true;
        eslint.enable = true;
        # biome.enable = true;
        gopls.enable = true;
        html.enable = true;
        # htmx.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        marksman.enable = true;
        nginx_language_server.enable = true;
        nil_ls = {
          enable = true;
          settings = {
            formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
            nix.flake = {
              autoArchive = true;
            };
          };
        };
        nixd = {
          enable = !lsp.nil_ls.enable;
          settings =
            let
              #flake = ''(builtins.getFlake "${self}")'';
              flake = ''builtins.getFlake (builtins.getEnv "FLAKE")'';
            in
            {
              nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
              options = {
                nixos.expr = "${flake}.nixosConfigurations.sonata.options";
                home-manager.expr = ''${flake}.homeConfigurations."glwbr@sonata".options'';
              };
            };
        };
        phpactor.enable = true;
        ruff.enable = true;
        templ.enable = true;
        ts_ls = {
          enable = !cfg.typescript-tools.enable;
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
                parameterNames.enabled = "literals";
                parameterTypes.enabled = false;
                variableTypes.enabled = false;
                propertyDeclarationTypes.enabled = true;
                functionLikeReturnTypes.enabled = false;
                enumMemberValues.enabled = true;
              };
              suggest.includeCompletionsForModuleExports = false;
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

  extraConfigLua =
    # lua
    ''
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

       require('lspconfig.ui.windows').default_options = {
           border = _border
       }

       -- this removes the gutter icons and colorize the line_number instead
       for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
        vim.fn.sign_define("DiagnosticSign" .. diag, {
          text = "",
          texthl = "DiagnosticSign" .. diag,
          linehl = "",
          numhl = "DiagnosticSign" .. diag,
        })
       end

       vim.lsp.inlay_hint.enable(true)

       local function goto_definition(split_cmd)
       local util = vim.lsp.util
       local log = require("vim.lsp.log")
       local api = vim.api

       local handler = function(_, result, ctx)
         if result == nil or vim.tbl_isempty(result) then
           local _ = log.info() and log.info(ctx.method, "No location found")
           return nil
         end

         if split_cmd then
           vim.cmd(split_cmd)
         end

         if vim.tbl_islist(result) then
           util.jump_to_location(result[1])

           if #result > 1 then
             vim.fn.setqflist(util.locations_to_items(result))
             api.nvim_command("copen")
             api.nvim_command("wincmd p")
           end
         else
           util.jump_to_location(result)
         end
       end

       return handler
      end

      vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit')
    '';
}
