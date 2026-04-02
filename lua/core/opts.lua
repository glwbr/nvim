local g = vim.g
local opt = vim.opt

-- Leader keys
g.mapleader = ' '
g.maplocalleader = ' '

-- stylua: ignore start
-- Display Settings
opt.termguicolors = true
opt.background = 'dark'
opt.cursorline = true
opt.wrap = false

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Invisible Characters
opt.list = true
opt.listchars = {
  tab = '» ',
  trail = '·',
  extends = '…',
  precedes = '…',
  nbsp = '␣',
}

-- Fill Characters
opt.fillchars = {
  foldopen = "▾",
  foldclose = "▸",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Command Line & Status
opt.cmdheight = 0
opt.laststatus = 3
opt.showmode = false
opt.signcolumn = 'yes'

-- Scrolling Behavior
opt.smoothscroll = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Split Preferences
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.winminwidth = 5

-- Cursor Configuration
opt.guicursor = {
  'n-v-c:block',
  'i-ci-ve:ver25',
  'r-cr:hor20',
  'o:hor50',
  'a:blinkwait700-blinkoff400-blinkon250',
  'sm:block-blinkwait175-blinkoff150-blinkon175',
}

-- Terminal Undercurl Support
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Search Settings
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.grepprg = 'rg --vimgrep'
opt.grepformat = '%f:%l:%c:%m'
opt.inccommand = 'split'

-- Completion Menu
opt.pumblend = 10
opt.pumheight = 10
opt.completeopt = 'menu,menuone,noselect'

-- Indentation & Text Formatting
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- File Handling
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.confirm = true

-- Folding
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99

-- Performance & Timing
opt.timeoutlen = 300
opt.updatetime = 200

-- Session Management
opt.sessionoptions = {
  'buffers', 'curdir', 'winsize',
  'help', 'globals', 'skiprtp', 'folds',
}

-- Netrw Settings
g.netrw_banner = 0
g.netrw_browse_split = 0
g.netrw_sort_by = 'name'
g.netrw_winsize = 25

-- Language & Spelling
opt.spelllang = { 'en' }
-- stylua: ignore end

-- SSH clipboard support
if vim.env.SSH_CONNECTION then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste '+',
      ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
  }
end
