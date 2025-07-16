{ pkgs, ... }:
{
  sharedLibraries = { };
  environmentVariables = { };
  extraLuaPackages = { };
  python3.libraries = { };
  extraWrapperArgs = { };

  lspsAndRuntimeDeps = with pkgs; {
    core = [ universal-ctags ripgrep fd jq wl-clipboard ];
    languages = {
      go = {
        lsp = [ gopls ];
        debug = [ delve ];
        lint = [ golangci-lint ];
        formatter = [ gofumpt gotools ];
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
        lsp = [ vtsls nodejs-slim_23 tailwindcss-language-server nodePackages.vscode-langservers-extracted yaml-language-server ];
        lint = [ eslint_d yamllint ];
        formatter = [ prettierd typst-fmt yamlfmt ];
      };
    };
  };

  startupPlugins = with pkgs.vimPlugins; {
    core = [
      blink-cmp
      blink-copilot
      copilot-lua
      conform-nvim
      lazy-nvim
      { plugin = luasnip; name = "LuaSnip"; }
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
    ];

    navigationAndWorkflow = [
      { plugin = harpoon2; name = "harpoon"; }
      tmux-navigator
      oil-nvim
    ];

    qualityOfLife = [ fidget-nvim snacks-nvim gitsigns-nvim nvim-lint todo-comments-nvim ];
    pluginUtilities = [ friendly-snippets lazydev-nvim ];

    ui = [
      { plugin = rose-pine; name = "rose-pine"; }
      { plugin = kanagawa-paper-nvim; name = "kanagawa-paper"; }
      colorful-menu-nvim
      incline-nvim
      kanagawa-nvim
      mini-icons
      nvim-highlight-colors
    ];
  };

  optionalPlugins = { };
}
