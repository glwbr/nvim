-- Shortcuts
local g = vim.g
local opt = vim.opt

-- Disable Netrw file explorer banner
g.netrw_banner = 0

-- Disable split pane
g.netrw_browse_split = 0

-- Sort files by name
g.netrw_sort_by = 'name'

-- Set Netrw window size
g.netrw_winsize = 25

-- Enable true color support
opt.termguicolors = true

-- Highlight current line
opt.cursorline = true

-- Show line numbers
opt.number = true

-- Show relative line numbers
opt.relativenumber = true

-- Show column marker
opt.colorcolumn = '120'

-- Disable line wrapping
opt.wrap = false

-- Show invisible characters
opt.list = true

-- Define invisible characters
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Enable smooth scrolling
opt.smoothscroll = true

-- Minimize command line height
opt.cmdheight = 0

-- Global status line
opt.laststatus = 3

-- Hide mode indicator
opt.showmode = false

-- Always show sign column
opt.signcolumn = 'yes'

-- Keep lines visible above/below cursor
opt.scrolloff = 8

-- Keep columns visible left/right
opt.sidescrolloff = 8

-- Minimum window width
opt.winminwidth = 5

-- Start with all folds open
opt.foldlevel = 99

-- Popup menu transparency
opt.pumblend = 10

-- Maximum popup menu height
opt.pumheight = 10

-- Completion menu options
opt.completeopt = 'menu,menuone,noselect'

-- Highlight search results
opt.hlsearch = true

-- Case-insensitive search
opt.ignorecase = true

-- Case-sensitive if uppercase present
opt.smartcase = true

-- Grep output format
opt.grepformat = '%f:%l:%c:%m'

-- Use ripgrep for searching
opt.grepprg = 'rg --vimgrep'

-- Disable backup files
opt.backup = false

-- Disable swap files
opt.swapfile = false

-- Enable persistent undo
opt.undofile = true

-- Maximum number of changes to remember
opt.undolevels = 10000

-- Internal encoding
opt.encoding = 'utf-8'

-- File encoding
opt.fileencoding = 'utf-8'

-- Spaces per tab
opt.tabstop = 4

-- Spaces per indent
opt.shiftwidth = 4

-- Spaces per tab when editing
opt.softtabstop = 4

-- Use spaces instead of tabs
opt.expandtab = true

-- Open vertical splits to the right
opt.splitright = true

-- Open horizontal splits below
opt.splitbelow = true

-- Maintain split screen position
opt.splitkeep = 'screen'

-- Time to wait for mapped sequence
opt.timeoutlen = 300

-- Faster completion
opt.updatetime = 200

-- Session options
opt.sessionoptions = {
  'buffers', -- Save buffer list
  'curdir', -- Save current directory
  'winsize', -- Save window sizes
  'help', -- Save help windows
  'globals', -- Save global variables
  'skiprtp', -- Don't save runtime path
  'folds', -- Save folds
}

-- Terminal Undercurl Support
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

vim.opt.guicursor = {
  'n-v-c:block',
  'i-ci-ve:ver25',
  'r-cr:hor20',
  'o:hor50',
  'a:blinkwait700-blinkoff400-blinkon250',
  'sm:block-blinkwait175-blinkoff150-blinkon175',
}
