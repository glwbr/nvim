{ lib, pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      log_level = "error";
      notify_on_error = true;
      notify_no_formatters = true;

      format_on_save =
        # lua
        ''
          function(bufnr)
            local ignore_filetypes = { "sql" }
            if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
              return
            end

            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match("/node_modules/") then
              return
            end

            return { timeout_ms = 500, lsp_format = "never" }
          end
        '';

      #format_after_save =
      #  # lua
      #  ''
      #    function(bufnr)
      #      local ignore_filetypes = { "sql" }
      #      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      #        return
      #      end

      #      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      #        return
      #      end

      #      local bufname = vim.api.nvim_buf_get_name(bufnr)
      #      if bufname:match("/node_modules/") then
      #        return
      #      end

      #      return { lsp_format = "fallback" }
      #    end
      #  '';

      formatters_by_ft = {
        "_" = [ "trim_whitespace" ];
        css = [ "prettierd" ];
        go = [
          "golangcilint"
          "goimports"
          "golines"
          "gofumpt"
        ];
        html = [ "prettierd" ];
        javascript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
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
        typescript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        yaml = [ "prettierd" ];
      };

      formatters = {
        #eslintd = {
        #  command = "${lib.getExe pkgs.eslint_d}";
        #  args = [
        #    "--fix-to-stdout"
        #    "--stdin"
        #    "--stdin-filename"
        #    "$FILENAME"
        #  ];
        #};
        dprint = {
          command = "${lib.getExe pkgs.dprint}";
        };
        jq = {
          command = "${lib.getExe pkgs.jq}";
        };
        golangcilint = {
          command = "${lib.getExe pkgs.golangci-lint}";
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
