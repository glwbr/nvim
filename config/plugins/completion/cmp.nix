_: {
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;

    settings = {
      mapping = {
        "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";

        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";

        "<C-e>" = "cmp.mapping.close()";
        "<C-Space>" = "cmp.mapping.complete()";

        "<C-y>" = "cmp.mapping.confirm({ select = true })";
      };

      experimental.ghost_text = true;
      snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

      performance = {
        debounce = 0;
        throttle = 0;
        fetching_timeout = 5;
        confirm_resolve_timeout = 80;
        max_view_entries = 20;
      };

      sources = [
        { name = "luasnip"; }
        { name = "nvim_lsp"; }
        {
          keyword_length = 3;
          name = "buffer";
          option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
        }
        { name = "copilot"; }
        {
          keyword_length = 2;
          name = "path";
        }
      ];

      view.docs.auto_open = false;

      window = {
        completion = {
          #border = "none";
          col_offset = -3;
          side_padding = 0;
          scrollbar = false;
          winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
          border = [
            "╭"
            "─"
            "╮"
            "│"
            "╯"
            "─"
            "╰"
            "│"
          ];
        };

        documentation = {
          #border = "none";
          col_offset = 0;
          side_padding = 0;
          border = [
            "╭"
            "─"
            "╮"
            "│"
            "╯"
            "─"
            "╰"
            "│"
          ];
          winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
        };
      };

      formatting = {
        fields = [
          "kind"
          "abbr"
          "menu"
        ];
        expandable_indicator = true;
      };
    };
  };
}
