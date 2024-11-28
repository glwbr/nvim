_: {
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      background = {
        light = "macchiato";
        dark = "mocha";
      };

      dim_inactive = {
        enabled = false;
        shade = "dark";
        percentage = 0.15;
      };

      flavour = "mocha"; # "latte", "mocha", "frappe", "macchiato", "auto"
      no_bold = true;
      no_italic = true;
      # no_underline = false;
      term_colors = true;
      transparent_background = true;

      styles = {
        comments = [ "italic" ];
        function = [ "bold" ];
        keywords = [ "italic" ];
        operators = [ "bold" ];
        conditionals = [ "bold" ];
        loops = [ "bold" ];
        booleans = [
          "bold"
          "italic"
        ];
      };

      integrations = {
        telescope = {
          enabled = true;
          style = "nvchad";
        };

        native_lsp = {
          enabled = true;
          inlay_hints.background = true;

          virtual_text = {
            errors = [ "italic" ];
            hints = [ "italic" ];
            information = [ "italic" ];
            ok = [ "italic" ];
            warnings = [ "italic" ];
          };

          underlines = {
            errors = [ "underline" ];
            hints = [ "underline" ];
            information = [ "underline" ];
            warnings = [ "underline" ];
          };
        };

        cmp = true;
        fidget = true;
        harpoon = true;
        gitsigns = true;
        notify = true;
        treesitter = true;
        which_key = true;
      };
    };
  };
}
