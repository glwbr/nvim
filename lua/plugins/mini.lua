return {
  {
    'echasnovski/mini.icons',
    opts = {
      style = 'glyph',
      file = {
        ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
        ['.bashrc'] = { glyph = '󱆃' },
        ['.zshrc'] = { glyph = '' },
        ['lazy.lua'] = { glyph = '󰒲', hl = 'MiniIconsAzure' },
        ['autocmd.lua'] = { glyph = '󰁨', hl = 'MiniIconsYellow' },
        ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      },
      filetype = { dotenv = { glyph = '', hl = 'MiniIconsYellow' } },
      lsp = {
        string = { glyph = '󰉾', hl = 'MiniIconsGreen' },
        copilot = { glyph = '', hl = 'MiniIconsRed' },
      },
    },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
  {
    'echasnovski/mini.statusline',
    opts = {
      use_icons = true,
      content = {
        active = nil, -- use default
        inactive = nil,
      },
    },
    config = function(_, opts)
      local statusline = require 'mini.statusline'
      statusline.setup(opts)
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  {
    'echasnovski/mini.surround',
    opts = {},
  },
}
