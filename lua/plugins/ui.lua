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
    'b0o/incline.nvim',
    event = 'BufReadPre',
    opts = {
      highlight = {
        groups = {
          InclineNormal = { default = true, group = 'lualine_a_normal' },
          InclineNormalNC = { default = true, group = 'Comment' },
        },
      },
      window = {
        margin = { horizontal = 1, vertical = 0 },
        placement = { horizontal = 'right', vertical = 'top' },
        overlap = { winbar = true, statusline = true },
        padding = 0,
      },
      render = function(ctx)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ctx.buf), ':t')

        if filename == '' then
          filename = '[No Name]'
        end

        local modified = vim.bo[ctx.buf].modified
        local icon, color = require('nvim-web-devicons').get_icon_color(filename)

        return {
          icon and { icon, guifg = color, ' ' } or '',
          { filename, gui = modified and 'bold' or 'bold' },
          { modified and ' ' .. '*' or '', guifg = '#d19a66' }, -- •
        }
      end,
    },
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
        ['autocmd.lua'] = { glyph = '󰁨', hl = 'MiniIconsYellow' },
        ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      },
      filetype = { dotenv = { glyph = '', hl = 'MiniIconsYellow' } },
      lsp = {
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
