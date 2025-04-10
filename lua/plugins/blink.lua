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
        border = 'rounded',
        draw = {
          padding = 0,
          columns = { { 'kind_icon', gap = 1 }, { gap = 1, 'label' }, { 'kind', gap = 1 } },
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
        update_delay_ms = 50,
        auto_show_delay_ms = 500,
        treesitter_highlighting = true,
        window = { border = 'rounded' },
      },
      ghost_text = { enabled = true, show_with_menu = true },
      list = { max_items = 30 },
    },

    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

    fuzzy = { implementation = 'prefer_rust' },
  },
  opts_extend = { 'sources.default' },
}
