{
  nvim =
    { ... }:
    {
      settings = {
        wrapRc = true;
        aliases = [ "v" ];
        hosts = {
          node.enable = false;
          python3.enable = false;
          ruby.enable = false;
        };
      };

      categories = {
        core = true;
        languages = true;

        # INFO: plugin categories
        navigationAndWorkflow = true;
        qualityOfLife = true;
        pluginUtilities = true;
        ui = true;

        # INFO: feature flags
        have_nerd_font = true;
      };
    };
}
