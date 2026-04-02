-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system {
    'git', 'clone', '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
    }, true, {})
  end
end
vim.opt.rtp:prepend(lazypath)

-- Core configuration
require 'core.opts'
require 'core.keymaps'
require 'core.autocmds'

-- Plugin manager
require('lazy').setup({
  { import = 'plugins' },
}, {
  change_detection = { notify = false },
  lockfile = vim.fn.stdpath 'config' .. '/lazy-lock.json',
  performance = {
    rtp = {
      disabled_plugins = { 'tohtml', 'tutor' },
    },
  },
})
