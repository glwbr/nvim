{ lib, pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      log_level = "error";
      notify_on_error = true;
      notify_no_formatters = true;

      formatters_by_ft = {
        "_" = [ "trim_whitespace" ];
        css = [
          "prettierd"
          "prettier"
        ];
        go = [
          "goimports"
          "golines"
          "gofumpt"
        ];
        html = [
          "prettierd"
          "prettier"
        ];
        javascript = [
          "prettierd"
          "prettier"
        ];
        javascriptreact = [
          "prettierd"
          "prettier"
        ];
        json = [ "jq" ];
        lua = [ "stylua" ];
        markdown = [ "prettierd" ];
        nix = [ "nixfmt" ];
        php = {
          __unkeyed-1 = "pint";
          __unkeyed-2 = "php_cs_fixer";
          stop_after_first = true;
        };
        python = [
          "ruff_format"
          "ruff_fix"
        ];
        typescript = [
          "prettierd"
          "prettier"
        ];
        typescriptreact = [
          "prettierd"
          "prettier"
        ];
        yaml = [
          "prettierd"
          "prettier"
        ];
      };

      formatters = {
        jq = {
          command = "${lib.getExe pkgs.jq}";
        };
        golines = {
          command = "${lib.getExe' pkgs.golines "golines"}";
        };
        gofumpt = {
          command = "${lib.getExe pkgs.gofumpt}";
        };
        nixfmt = {
          command = "${lib.getExe pkgs.nixfmt-rfc-style}";
        };
        php_cs_fixer = {
          command = "${lib.getExe pkgs.php83Packages.php-cs-fixer}";
          args = [
            "fix"
            "--quiet"
            "--config=.php-cs-fixer.php"
            "--using-cache=no"
            "$FILENAME"
          ];
          stdin = false;
        };
        prettierd = {
          command = "${lib.getExe pkgs.prettierd}";
        };
        ruff = {
          command = "${lib.getExe pkgs.ruff}";
        };
        stylua = {
          command = "${lib.getExe pkgs.stylua}";
        };
      };
    };
  };
}
