return {
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      notification = {
        poll_rate = 100,
        filter = vim.log.levels.INFO,
        view = { stack_upwards = false },
        window = { winblend = 0, border = 'none' },
      },

      progress = {
        ignore_done_already = true,
        ignore_empty_message = true,
        display = {
          done_icon = '',
          progress_icon = { pattern = 'dots_pulse' },
        },
      },
    },
  },
  {
    'b0o/incline.nvim',
    event = 'BufReadPre',
    opts = {
      window = {
        margin = { horizontal = 1, vertical = 0 },
        placement = { horizontal = 'right', vertical = 'top' },
        overlap = { winbar = true, statusline = true },
        padding = 0,
        winhighlight = {
          active = {
            EndOfBuffer = 'None',
            Normal = 'Normal',
            Search = 'None',
          },
          inactive = {
            EndOfBuffer = 'None',
            Normal = 'Normal',
            Search = 'None',
          },
        },
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
      virtual_symbol = '■',
      enable_tailwind = false,
      enable_named_colors = false,
    },
  },
}
