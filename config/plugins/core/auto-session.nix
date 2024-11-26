_: {
  plugins.auto-session = {
    enable = true;
    settings = {
      suppressed_dirs = [ "~/" ];
      auto_restore_last_session = true;
      session_lens = {
        previewer = true;
        mappings = {
          search_session.__raw = ''
            vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, { noremap = true, })
          '';
        };
      };
    };
  };
}
