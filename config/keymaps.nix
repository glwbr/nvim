_:
let
  #TODO: export these functions to lib
  mkKeymap = mode: key: action: desc: {
    inherit mode key action;
    options = {
      silent = true;
      noremap = true;
      inherit desc;
    };
  };

  mkModeMap =
    mode: key: action: desc:
    (mkKeymap mode key action desc);
  mkNormap = mkModeMap "n";
  mkVismap = mkModeMap "v";
in
{
  globals.mapleader = " ";

  keymaps = [
    # Disable keys
    (mkNormap "<Up>" "<nop>" "Disable up arrow")
    (mkNormap "<Down>" "<nop>" "Disable down arrow")
    (mkNormap "<Left>" "<nop>" "Disable left arrow")
    (mkNormap "<Right>" "<nop>" "Disable right arrow")

    # Clipboard mappings
    (mkKeymap [
      "n"
      "v"
    ] "<leader>d" "\"_d" "Delete (no clipboard)")
    (mkKeymap [
      "n"
      "v"
    ] "<leader>y" "\"+y" "Yank to clipboard")
    (mkKeymap [
      "n"
      "v"
    ] "<leader>Y" "\"+Y" "Yank line to clipboard")
    (mkKeymap "x" "<leader>p" "\"_dP" "Paste over selection (no clipboard)")

    # Editing
    (mkNormap "J" "mzJ`z" "Join lines without moving cursor")
    (mkNormap "<leader>x" "<cmd>!chmod +x %<CR>" "Make file executable")
    (mkVismap "<" "<gv" "Re-select after indenting")
    (mkVismap ">" ">gv" "Re-select after unindenting")

    # File explorer
    (mkNormap "<leader>pv" "<cmd>Ex<CR>" "Project view")

    # Misc
    (mkKeymap [
      "n"
      "i"
    ] "<esc>" "<cmd>nohlsearch<CR><esc>" "Clear search & escape")

    # Navigation
    (mkNormap "<C-d>" "<C-d>zz" "Scroll down, centered")
    (mkNormap "<C-u>" "<C-u>zz" "Scroll up, centered")
    (mkNormap "n" "nzzzv" "Next search result, centered")
    (mkNormap "N" "Nzzzv" "Previous search result, centered")

    # Snippets
    (mkKeymap [
      "s"
      "i"
    ] "<C-k>" "<cmd>JumpOrExpand<CR>" "Jump/expand snippet")
    (mkKeymap [
      "s"
      "i"
    ] "<C-j>" "<cmd>JumpBackward<CR>" "Jump backward snippet")

    # Window management
    (mkNormap "<C-k>" "<C-w><C-k>" "Move to the Upper Split")
    (mkNormap "<C-j>" "<C-w><C-j>" "Move to the Bottom Split")
    (mkNormap "<C-h>" "<C-w><C-h>" "Move to the Left Split")
    (mkNormap "<C-l>" "<C-w><C-l>" "Move to the Right Split")
    (mkNormap "<C-Down>" ":resize +2<CR>" "Increase Split Height")
    (mkNormap "<C-Up>" ":resize -2<CR>" "Decrease Split Height")
    (mkNormap "<C-Left>" ":vertical resize -2<CR>" "Decrease Window Width")
    (mkNormap "<C-Right>" ":vertical resize +2<CR>" "Increase Window Width")
  ];
}
