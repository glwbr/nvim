_: {
  plugins.dashboard = {
    enable = true;
    settings = {
      config = {
        week_header.enable = true;
        packages.enable = false;
        footer = [ "Corgis gonna shake, shake, shake..." ];
        project = {
          enable = true;
          limit = 5;
          icon = "󰏖 ";
          label = "projects:";
          action = "Telescope find_files cwd=";
        };
        mru = {
          limit = 8;
          icon = " ";
          label = "recent Files:";
          cwd_only = false;
        };
        shortcut = [
          {
            action.__raw = "function(path) vim.cmd('Telescope find_files') end";
            desc = "files";
            group = "Label";
            icon = " ";
            icon_hl = "@variable";
            key = "f";
          }
          {
            action = "Telescope git_commits";
            desc = "commits";
            group = "Number";
            icon = " ";
            key = "d";
          }
        ];
      };
    };
  };
}
