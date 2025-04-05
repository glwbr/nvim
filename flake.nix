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
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;

      # Import modularized components
      overlays = import ./nix/overlays.nix { inherit utils inputs; };
      categoryDefinitions = import ./nix/categories.nix;
      packageDefinitions = import ./nix/packages.nix;
      defaultPackageName = "nvim";
    in
    forEachSystem (
      system:
      let
        inherit (utils) baseBuilder;
        nixCatsBuilder = baseBuilder luaPath {
          inherit nixpkgs;
          inherit system;
          dependencyOverlays = overlays;
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
          luaPath
          packageDefinitions
          ;
        dependencyOverlays = overlays;
      };
      homeModule = utils.mkHomeModules {
        inherit nixpkgs;
        inherit
          categoryDefinitions
          defaultPackageName
          luaPath
          packageDefinitions
          ;
        dependencyOverlays = overlays;
      };
    };
}
