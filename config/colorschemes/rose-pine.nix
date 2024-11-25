_:
let
  lua = x: { __raw = x; };
in
{
  colorschemes.rose-pine = {
    enable = true;
    settings = {
      style = "main"; # "main", "moon", "dawn" or raw lua code
      styles = {
        bold = false;
        italic = true;
        transparency = false;
      };
      highlightGroups = {
        TelescopeNormal = {
          bg = lua "require('rose-pine.palette').base";
          fg = lua "require('rose-pine.palette').surface";
        };
        TelescopeBorder = {
          bg = lua "require('rose-pine.palette').base";
          fg = lua "require('rose-pine.palette').surface";
        };
        TelescopePreviewTitle = {
          bg = lua "require('rose-pine.palette').base";
          fg = lua "require('rose-pine.palette').surface";
        };
      };
    };
  };
}
