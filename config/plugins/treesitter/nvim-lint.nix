{ lib, pkgs, ... }:
{
  plugins.lint = {
    enable = true;

    lintersByFt = {
      docker = [ "hadolint" ];
      javascript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      json = [ "jsonlint" ];
      lua = [ "selene" ];
      nix = [ "statix" ];
      typescript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      yaml = [ "yamllint" ];
    };

    linters = {
      eslint_d = {
        cmd = lib.getExe pkgs.eslint_d;
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
