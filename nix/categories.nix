{ pkgs, ... }:
{
  sharedLibraries = { };
  environmentVariables = { };
  extraLuaPackages = { };
  python3.libraries = { };
  extraWrapperArgs = { };

  lspsAndRuntimeDeps = with pkgs; {
    core = [
      universal-ctags
      ripgrep
      fd
      jq
      wl-clipboard
    ];
    languages = {
      go = {
        debug = [ delve ];
        lint = [ golangci-lint ];
      };
      docker = {
        lint = [ hadolint ];
      };
      lua = {
        lsp = [ lua-language-server ];
        lint = [ selene ];
        formatter = [ stylua ];
      };
      nix = {
        lsp = [ nix ];
        lint = [ nixd ];
        formatter = [ nixfmt-rfc-style ];
      };
      web = {
        lsp = [
          vtsls
          tailwindcss-language-server
          nodePackages.vscode-langservers-extracted
        ];
        lint = [
          nodePackages.jsonlint
          nodePackages.eslint_d
        ];
        formatter = [ prettierd ];
      };
    };
  };

  startupPlugins = with pkgs.vimPlugins; {
    core = [
      blink-cmp
      conform-nvim
      lazy-nvim
      {
        plugin = luasnip;
        name = "LuaSnip";
      }
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
    ];

    navigationAndWorkflow = [
      {
        plugin = harpoon2;
        name = "harpoon";
      }
      tmux-navigator
      oil-nvim
    ];

    qualityOfLife = [
      fidget-nvim
      {
        plugin = incline-nvim;
        name = "incline";
      }
      snacks-nvim
      gitsigns-nvim
      nvim-lint
      todo-comments-nvim
    ];

    pluginUtilities = [
      friendly-snippets
      lazydev-nvim
    ];

    ui = [
      {
        plugin = catppuccin-nvim;
        name = "catppuccin";
      }
      {
        plugin = kanagawa-paper-nvim;
        name = "kanagawa";
      }
      {
        plugin = gruvbox-material;
        name = "gruvbox";
      }

      mini-icons
    ];
  };

  optionalPlugins = { };
}
