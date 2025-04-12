{ utils, inputs }:

[
  (utils.standardPluginOverlay inputs)
  (final: prev: {
    vimPlugins = prev.vimPlugins // {
      kanagawa-paper-nvim = prev.vimUtils.buildVimPlugin {
        nvimSkipModules = [ "wezterm.theme_switcher" ];
        name = "kanagawa-paper.nvim";
        src = inputs.kanagawa-paper-nvim;
      };
    };
  })
]
