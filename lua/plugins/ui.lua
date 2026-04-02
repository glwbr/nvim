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
          done_icon = '',
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
          active = { EndOfBuffer = 'None', Normal = 'Normal', Search = 'None' },
          inactive = { EndOfBuffer = 'None', Normal = 'Normal', Search = 'None' },
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
          { filename, gui = 'bold' },
          { modified and ' *' or '', guifg = '#d19a66' },
        }
      end,
    },
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
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      delay = 200,
      icons = { mappings = false },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>x', group = 'Li[x]ts' },
        { '<leader>w', group = '[W]indow' },
        { '<leader>g', group = '[G]it' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>r', group = '[R]ename/Replace' },
        { 'g', group = '[G]o to' },
      },
    },
  },
}
