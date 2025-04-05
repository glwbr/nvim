{ utils, inputs }:

[
  (utils.standardPluginOverlay inputs)
  (final: prev: {
    vimPlugins = prev.vimPlugins // {
      incline-nvim = prev.vimUtils.buildVimPlugin {
        name = "incline.nvim";
        src = inputs.incline-nvim;
      };
    };
  })
]
