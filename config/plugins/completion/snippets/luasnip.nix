_: {
  plugins = {
    friendly-snippets.enable = true;
    luasnip = {
      enable = true;
      # fromLua = [{paths = ./lua;}];
      fromVscode = [
        {
          lazyLoad = true;
          paths = ./json;
        }
      ];
    };
  };

  extraConfigLua =
    # lua
    ''
      local ls = require "luasnip"
      vim.snippet.expand = ls.lsp_expand

      vim.snippet.active = function(filter)
        filter = filter or {}
        filter.direction = filter.direction or 1

        if filter.direction == 1 then
          return ls.expand_or_jumpable()
        else
          return ls.jumpable(filter.direction)
        end
      end

      vim.snippet.jump = function(direction)
        if direction == 1 then
          if ls.expandable() then
            return ls.expand_or_jump()
          else
            return ls.jumpable(1) and ls.jump(1)
          end
        else
          return ls.jumpable(-1) and ls.jump(-1)
        end
      end

      vim.snippet.stop = ls.unlink_current

      --WARN:a temporary way of defining commands for nixvim keymaps
      -- since it would be a verbose way pass directly to the mkKeymap
      --TODO: move this to a lua function folder?
      vim.api.nvim_create_user_command('JumpOrExpand', function()
        return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
      end, {})

      vim.api.nvim_create_user_command('JumpBackwards', function()
        return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
      end, {})
    '';
}
