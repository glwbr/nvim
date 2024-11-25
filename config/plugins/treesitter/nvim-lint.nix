{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    golangci-lint
    eslint_d
    nodePackages.jsonlint
    selene
    statix
    yamllint
  ];

  plugins.lint = {
    enable = true;
    lintersByFt = {
      go = [ "golangci-lint" ];
      javascript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      json = [ "jsonlint" ];
      lua = [ "selene" ];
      nix = [ "statix" ];
      typescript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      yaml = [ "yamllint" ];
    };
  };
}
