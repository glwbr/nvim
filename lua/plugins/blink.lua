return {
  'saghen/blink.cmp',
  version = '*',
  dependencies = {
    'fang2hou/blink-copilot',
    'rafamadriz/friendly-snippets',
    { 'xzbdmw/colorful-menu.nvim', opts = {} },
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
    signature = {
      enabled = true,
    },
    completion = {
      menu = {
        auto_show = false,
        border = 'none',
        draw = {
          padding = { 1, 1 },
          -- columns = { { 'kind_icon' }, { 'label', gap = 1 } },
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon' } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = { border = 'none' },
      },
      ghost_text = { enabled = true, show_with_menu = false },
      list = { max_items = 30 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = { copilot = { name = 'copilot', module = 'blink-copilot', async = true } },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'prefer_rust' },
  },
  opts_extend = { 'sources.default' },
}
