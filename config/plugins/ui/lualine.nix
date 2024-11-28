_: {
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
        section_separators = {
          left = "";
          right = "";
        };
        component_separtors = {
          left = "";
          right = "";
        };
      };
      sections = {
        lualine_a = [ "branch" ];
        lualine_b = [
          {
            name = "diagnostics";
            sources = [ "nvim_lsp" ];
          }
        ];
        lualine_c = [
          {
            name = "filename";
            file_status = true;
            newfile_status = true;
            path = 4;
          }
        ];
        lualine_x = [ "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ { } ];
      };
    };
  };
}
