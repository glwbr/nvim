{
  description = "My neovim fla(ke|vour).";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    incline-nvim = {
      url = "github:b0o/incline.nvim";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      nixCats,
      incline-nvim,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config.allowUnfree = true;
      # dependencyOverlays = [ (utils.standardPluginOverlay inputs) ];
      dependencyOverlays = [
        (utils.standardPluginOverlay inputs)
        (final: prev: {
          vimPlugins = prev.vimPlugins // {
            incline-nvim = prev.vimUtils.buildVimPlugin {
              name = "incline.nvim";
              src = incline-nvim;
            };
          };
        })
      ];

      categoryDefinitions =
        { pkgs, ... }:
        {
          sharedLibraries = { };
          environmentVariables = { };
          extraLuaPackages = { };
          extraPython3Packages = { };
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
              };
              lua = [
                lua-language-server
                selene
                stylua
              ];
              nix = [
                nix
                nixd
                nixfmt-rfc-style
              ];
              hypr = [ hyprls ];
              web = {
                markdown = [ markdownlint-cli ];
                javascript = [
                  eslint_d
                  nodePackages.prettier
                  typescript-language-server
                ];
                json = with nodePackages; [ jsonlint ];
              };
            };
          };

          startupPlugins = with pkgs.vimPlugins; {
            core = [
              lazy-nvim
              nvim-lspconfig
              nvim-treesitter.withAllGrammars
              plenary-nvim
            ];

            navigationAndWorkflow = [
              {
                plugin = harpoon2;
                name = "harpoon";
              }
            ];

            qualityOfLife = [
              blink-cmp
              conform-nvim
              fidget-nvim
              {
                plugin = incline-nvim;
                name = "incline";
              }
              nvim-navic
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
              kanagawa-nvim
              {
                plugin = catppuccin-nvim;
                name = "catppuccin";
              }
              nvim-web-devicons
              {
                plugin = rose-pine;
                name = "rose-pine";
              }
            ];
          };

          optionalPlugins = { };
        };

      packageDefinitions = {
        nvim =
          { ... }:
          {
            settings = {
              wrapRc = true;
              aliases = [ "v" ];
              withNodeJs = false;
              withRuby = false;
              withPython3 = false;
            };

            categories = {
              core = true;
              languages = true;

              navigationAndWorkflow = true;
              qualityOfLife = true;
              pluginUtilities = true;
              ui = true;

              have_nerd_font = true;
            };
          };
      };
      defaultPackageName = "nvim";
    in
    forEachSystem (
      system:
      let
        inherit (utils) baseBuilder;
        nixCatsBuilder = baseBuilder luaPath {
          inherit nixpkgs;
          inherit system dependencyOverlays;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = utils.mkAllWithDefault defaultPackage;
        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ (nixCatsBuilder defaultPackageName) ];
            inputsFrom = [ ];
            shellHook = "";
          };
        };
      }
    )
    // {
      nixosModule = utils.mkNixosModules {
        inherit nixpkgs;
        inherit
          categoryDefinitions
          defaultPackageName
          dependencyOverlays
          luaPath
          packageDefinitions
          ;
      };
      homeModule = utils.mkHomeModules {
        inherit nixpkgs;
        inherit
          categoryDefinitions
          defaultPackageName
          dependencyOverlays
          luaPath
          packageDefinitions
          ;
      };
    };
}
