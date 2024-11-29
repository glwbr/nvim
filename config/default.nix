_: {
  imports = [
    ./colorschemes
    ./plugins

    ./autocmds.nix
    ./keymaps.nix
    ./options.nix
  ];

  withPython3 = false;
  withRuby = false;
}
