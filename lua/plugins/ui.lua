return {
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      notification = { window = { winblend = 0 } },
    },
    config = function(_, opts)
      require('fidget').setup(opts)
    end,
  },
  {
    'echasnovski/mini.icons',
    opts = {
      style = 'glyph',
      file = {
        ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
        ['.bashrc'] = { glyph = '󱆃' },
        ['.zshrc'] = { glyph = '' },
        ['lazy.lua'] = { glyph = '󰒲', hl = 'MiniIconsAzure' },
        ['.editorconfig'] = { glyph = '', hl = 'MiniIconsGrey' },
        ['autocmd.lua'] = { glyph = '󰁨', hl = 'MiniIconsYellow' },
        ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      },
      filetype = { dotenv = { glyph = '', hl = 'MiniIconsYellow' } },
      lsp = {
        ['function'] = { glyph = '󰡱' },
        string = { glyph = '󰉾', hl = 'MiniIconsGreen' },
        copilot = { glyph = '', hl = 'MiniIconsRed' },
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
    'brenoprata10/nvim-highlight-colors',
    opts = {
      render = 'virtual',
      virtual_symbol = '',
    },
  },
}
