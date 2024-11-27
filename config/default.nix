_: {
  imports = [
    ./colorschemes
    ./plugins

    ./autocmds.nix
    ./keymaps.nix
    ./options.nix
  ];

  config = {
    withNodeJs = false;
    withPerl = false;
    withPython3 = false;
    withRuby = false;
  };
}
