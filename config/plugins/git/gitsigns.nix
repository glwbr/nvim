{ icons, ... }:
{
  plugins = {
    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        current_line_blame_formatter = " <author> • <author_time:%R> – <summary>";
        current_line_blame_formatter_nc = " Uncommitted changes";
        signs = {
          add.text = icons.GitSign;
          change.text = icons.GitSign;
          changedelete.text = icons.GitSign;
          delete.text = icons.GitSign;
          topdelete.text = icons.GitSign;
          untracked.text = icons.GitSign;
        };
      };
    };
  };
}
