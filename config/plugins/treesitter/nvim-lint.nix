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
      javascript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      json = [ "jsonlint" ];
      lua = [ "selene" ];
      nix = [
        "deadnix"
        "nix"
      ] ++ lib.optionals (!lsp.statix.enable) [ "statix" ];
      typescript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      yaml = [ "yamllint" ];
    };

    linters = {
      deadnix = {
        cmd = lib.getExe pkgs.deadnix;
      };
      eslint_d = {
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
