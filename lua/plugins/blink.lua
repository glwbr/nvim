return {
  'saghen/blink.cmp',
  version = '*',
  dependencies = {
    'fang2hou/blink-copilot',
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },
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
          padding = { 1, 1 },
          columns = {
            { 'kind_icon', gap = 1 },
            { gap = 1, 'label' },
            { 'kind', gap = 1 },
          },
          components = {
            kind_icon = {
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            kind = {
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
        window = { border = 'none' },
      },
      ghost_text = { enabled = true, show_with_menu = false },
      list = { max_items = 30 },
    },
    sources = {
      default = { 'lsp', 'snippets', 'path', 'buffer', 'copilot' },
      providers = {
        copilot = {
          async = true,
          name = 'copilot',
          score_offset = 100,
          module = 'blink-copilot',
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.kind_icon = ' '
              item.kind_name = 'Copilot'
            end
            return items
          end,
        },
      },
    },
    fuzzy = { implementation = 'prefer_rust' },
  },
  opts_extend = { 'sources.default' },
}
