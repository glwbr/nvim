return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'normal',
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        update_delay_ms = 50,
        treesitter_highlighting = true,
        window = {
          min_width = 10,
          max_width = 80,
          max_height = 20,
          border = 'padded',
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
          scrollbar = true,
          direction_priority = {
            menu_north = { 'e', 'w', 'n', 's' },
            menu_south = { 'e', 'w', 's', 'n' },
          },
        },
      },
      ghost_text = {
        enabled = true,
      },
      list = {
        max_items = 30,
      },
    },
    keymap = { preset = 'default' },
    sources = {
      cmdline = {},
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { 'sources.default' },
}
