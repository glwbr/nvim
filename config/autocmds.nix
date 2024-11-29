_: {
  autoCmd = [
    {
      event = "FileType";
      pattern = [
        "*.md"
        "*.tex"
        "*.txt"
        "*.typ"
      ];
      command = "setlocal spell spelllang=en,pt";
      desc = "Enable spellcheck.";
    }
    {
      event = "TextYankPost";
      pattern = "*";
      callback.__raw = ''
        function()
                                                        vim.highlight.on_yank({higroup='IncSearch', timeout=50})
        end
      '';
      desc = "Highlight yanked text.";
    }
    {
      event = "BufReadPost";
      callback.__raw = ''
        function()
           local mark = vim.api.nvim_buf_get_mark(0, '"')
           local lcount = vim.api.nvim_buf_line_count(0)
           if mark[1] > 0 and mark[1] <= lcount then
               pcall(vim.api.nvim_win_set_cursor, 0, mark)
           end
        end
      '';
      desc = "Go to last location when opening a buffer.";
    }
    {
      event = "FileType";
      pattern = [
        "go"
        "json"
        "lua"
      ];
      callback.__raw = ''
        function()
           vim.bo.tabstop = 2
           vim.bo.shiftwidth = 2
        end
      '';
      desc = "Set tabstop and shiftwidth for specific filetypes.";
    }
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
      desc = "Open help in a vertical split.";
    }
    {
      event = "BufWritePre";
      pattern = [
        "*.tsx"
        "*.ts"
        "*.jsx"
        "*.js"
      ];
      command = "silent! EslintFixAll";
      desc = "run eslint before saving";
    }
    {
      event = [ "FileType" ];
      pattern = "TelescopePrompt";
      command = "inoremap <buffer><silent> <ESC> <ESC>:close!<CR>";
      desc = "Close telescope prompt in insert mode with escape.";
    }
  ];
}
