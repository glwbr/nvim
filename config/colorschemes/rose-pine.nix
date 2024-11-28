_:
let
  lua = x: { __raw = x; };
in
{
  colorschemes.rose-pine = {
    enable = true;
    settings = {
      variant = "main";
      styles = {
        bold = false;
        italic = true;
        transparency = true;
      };
      highlight_groups = {
        Comment = {
          fg = "highlight_med";
        };
        # TelescopePreviewTitle = {
        #   fg = "love";
        #   bg = "base";
        # };
      };
    };
  };
}
