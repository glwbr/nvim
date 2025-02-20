return {
  'j-hui/fidget.nvim',
  opts = { notification = { window = { winblend = 0 } } },
  config = function(_, opts)
    require('fidget').setup(opts)
  end,
}
