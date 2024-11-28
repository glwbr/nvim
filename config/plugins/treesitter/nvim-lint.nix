{
  config,
  lib,
  pkgs,
  ...
}:
let
  lsp = config.plugins.lsp.servers;
in
{
  plugins.lint = {
    enable = true;

    lintersByFt = {
      docker = [ "hadolint" ];
      golangcilint = [ "golangcilint" ];
      javascript = lib.mkIf (!lsp.eslint.enable) [ "eslint_d" ];
      javascriptreact = lib.optionals (!lsp.eslint.enable) [ "eslint_d" ];
      json = [ "jsonlint" ];
      lua = [ "selene" ];
      nix = [
        "deadnix"
        "nix"
      ] ++ lib.optionals (!lsp.statix.enable) [ "statix" ];
      typescript = lib.optionals (!lsp.eslint.enable) [ "eslint_d" ];
      typescriptreact = lib.optionals (!lsp.eslint.enable) [ "eslint_d" ];
      yaml = [ "yamllint" ];
    };

    linters = {
      #biome = {
      #  cmd = lib.getExe pkgs.biome;
      #};
      deadnix = {
        cmd = lib.getExe pkgs.deadnix;
      };
      eslint_d = lib.mkIf (!lsp.eslint.enable) {
        cmd = lib.getExe pkgs.eslint_d;
      };
      golangcilint = {
        cmd = lib.getExe pkgs.golangci-lint;
      };
      hadolint = {
        cmd = lib.getExe pkgs.hadolint;
      };
      jsonlint = {
        cmd = lib.getExe' pkgs.nodePackages.jsonlint "jsonlint";
      };
      selene = {
        cmd = lib.getExe pkgs.selene;
      };
      statix = {
        cmd = lib.getExe pkgs.statix;
      };
      yamllint = {
        cmd = lib.getExe pkgs.yamllint;
      };
    };
  };
}
