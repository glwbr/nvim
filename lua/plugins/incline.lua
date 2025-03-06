return {
  'b0o/incline.nvim',
  name = 'incline',
  event = 'BufReadPre',
  config = function()
    require('incline').setup {
      highlight = {
        groups = {
          InclineNormal = { default = true, group = 'lualine_a_normal' },
          InclineNormalNC = { default = true, group = 'Comment' },
        },
      },
      window = {
        margin = { horizontal = 0, vertical = 0 },
        placement = { horizontal = 'right', vertical = 'top' },
        overlap = {
          tabline = false,
          winbar = true,
          borders = true,
          statusline = true,
        },
        padding = 0,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')

        if filename == '' then
          filename = '[No Name]'
        end

        local modified = vim.bo[props.buf].modified

        local icon, color = require('nvim-web-devicons').get_icon_color(filename)

        return {
          { icon, guifg = color },
          { icon and ' ' or '' },
          { filename, gui = modified and 'italic' or 'bold' },
          { vim.bo[props.buf].modified and ' ' or '', guifg = '#d19a66' }, -- •
        }
      end,
    }
    -- user represents the name
  end,
}
