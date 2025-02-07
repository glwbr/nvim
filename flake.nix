{
  description = "A neovim flake, built with categories in mind.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = { nixpkgs, nixCats, ... }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config.allowUnfree = true;
      dependencyOverlays = [ (utils.standardPluginOverlay inputs) ];

      categoryDefinitions = { pkgs, ... }: {
        sharedLibraries = { };
        environmentVariables = { };
        extraLuaPackages = { };
        extraPython3Packages = { };
        extraWrapperArgs = { };

        lspsAndRuntimeDeps = with pkgs; {
          general = {
            core = [ universal-ctags ripgrep fd ];
            debug = [ delve ];
            lua = [ lua-language-server stylua ];
            nix = [ nix nixd nixfmt-classic ];
            web = {
              # html = [vscode-langservers-extracted];
              javascript = [ eslint_d prettierd typescript-language-server ];
            };
          };
        };

        startupPlugins = with pkgs.vimPlugins; {
          general = {
            core = [
              conform-nvim
              nvim-lspconfig
              nvim-lint
              nvim-treesitter.withAllGrammars
              plenary-nvim
              lazy-nvim
            ];
            qol = [ todo-comments-nvim ];
          };
        };

        optionalPlugins = { };
      };

      packageDefinitions = {
        nvim = { ... }: {
          settings = {
            wrapRc = true;
            aliases = [ "v" ];
          };
          categories = {
            general = true;
            have_nerd_font = true;
          };
        };
      };
      defaultPackageName = "nvim";
    in forEachSystem (system:
      let
        inherit (utils) baseBuilder;
        nixCatsBuilder = baseBuilder luaPath {
          inherit nixpkgs;
          inherit system dependencyOverlays;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs { inherit system; };
      in {
        packages = utils.mkAllWithDefault defaultPackage;
        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = "";
          };
        };
      }) // {
        nixosModule = utils.mkNixosModules {
          inherit nixpkgs;
          inherit categoryDefinitions defaultPackageName dependencyOverlays
            luaPath packageDefinitions;
        };
        homeModule = utils.mkHomeModules {
          inherit nixpkgs;
          inherit categoryDefinitions defaultPackageName dependencyOverlays
            luaPath packageDefinitions;
        };
      };
}
