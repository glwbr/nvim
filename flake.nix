{
  description = "My neovim fla(ke|vour).";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    kanagawa-paper-nvim = {
      url = "github:thesimonho/kanagawa-paper.nvim";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;

      # Import modularized components
      categoryDefinitions = import ./nix/categories.nix;
      packageDefinitions = import ./nix/packages.nix;
      dependencyOverlays = import ./nix/overlays.nix { inherit utils inputs; };
      defaultPackageName = "nvim";
    in
    forEachSystem (
      system:
      let
        inherit (utils) baseBuilder;
        nixCatsBuilder = baseBuilder luaPath {
          inherit nixpkgs dependencyOverlays system;
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
