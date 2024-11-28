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
        italic = false;
        transparency = true;
      };
      higght_groups = {
        Comment = {
          fg = "highlight_med";
        };
        TelescopeNormal = {
          bg = "base";
          fg = "highlight_med";
        };
        TelescopeBorder = {
          bg = "base";
          fg = "base";
        };
        TelescopePromptNormal = {
          bg = "love";
        };
        TelescopePromptBorder = {
          bg = "love";
          fg = "love";
        };
        TelescopePromptTitle = {
          bg = "love";
          fg = "love";
        };
        TelescopePreviewTitle = {
          bg = "base";
          fg = "base";
        };
        TelescopeResultsTitle = {
          bg = "base";
          fg = "base";
        };
      };
    };
  };
}
