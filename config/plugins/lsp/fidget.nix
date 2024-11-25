{ icons, ... }:
{
  plugins.fidget = {
    enable = true;
    logger = {
      level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
      floatPrecision = 1.0e-2;
    };

    progress = {
      pollRate = 0;
      suppressOnInsert = true;
      ignoreDoneAlready = false;
      ignoreEmptyMessage = false;
      clearOnDetach = ''
        function(client_id)
          local client = vim.lsp.get_client_by_id(client_id)
          return client and client.name or nil
        end
      '';
      notificationGroup = "function(msg) return msg.lsp_client.name end";
      # List of LSP servers to ignore
      ignore = [ ];
      lsp = {
        progressRingbufSize = 0;
      };

      display = {
        renderLimit = 16;
        doneTtl = 3;
        doneIcon = icons.GitStaged;
        doneStyle = "Constant";
        progressTtl = "math.huge";
        progressIcon = {
          pattern = "dots";
          period = 1;
        };
        progressStyle = "WarningMsg";
        groupStyle = "Title";
        iconStyle = "Question";
        priority = 30;
        skipHistory = true;
        formatMessage = "require 'fidget.progress.display'.default_format_message";
        formatAnnote = "function (msg) return msg.title end";
        formatGroupName = "function (group) return tostring (group) end";
      };
    };

    notification = {
      pollRate = 10;
      filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
      historySize = 128;
      overrideVimNotify = true;
      redirect = ''
        function(msg, level, opts)
          if opts and opts.on_open then
            return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
          end
        end
      '';
      configs.default = "require 'fidget.notification'.default_config";

      window = {
        normalHl = "Comment";
        winblend = 0;
        border = "none"; # none, single, double, rounded, solid, shadow
        zindex = 45;
        maxWidth = 0;
        maxHeight = 0;
        xPadding = 1;
        yPadding = 0;
        align = "bottom";
        relative = "editor";
      };

      view = {
        stackUpwards = true;
        iconSeparator = " ";
        groupSeparator = "---";
        groupSeparatorHl = "Comment";
      };
    };
  };
}
