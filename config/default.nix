_: {
  imports = [
    ./colorschemes
    ./plugins

    ./autocmds.nix
    ./keymaps.nix
    ./options.nix
  ];

  withNodeJs = false;
  withPerl = false;
  withPython3 = false;
  withRuby = false;
}
