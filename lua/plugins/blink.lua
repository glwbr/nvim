return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = { nerd_font_variant = 'normal' },
    keymap = { preset = 'default' },
    snippets = { preset = 'luasnip' },
    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        update_delay_ms = 50,
        treesitter_highlighting = true,
      },
      ghost_text = { enabled = true, show_with_menu = false },
      list = { max_items = 30 },
    },

    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

    fuzzy = { implementation = 'rust' },
  },
  opts_extend = { 'sources.default' },
}
