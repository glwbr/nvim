vim.diagnostic.config {
  virtual_text = false,                       -- Disable inline diagnostic messages
  signs = true,                               -- Show diagnostic signs in sign column
  underline = true,                           -- Underline diagnostic locations
  update_in_insert = false,                   -- Don't update diagnostics in insert mode
  severity_sort = true,                       -- Sort diagnostics by severity
}

-- Enable undercurl support in terminal
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Netrw file explorer settings
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_sort_by = 'name'                  -- Sort files by name
vim.g.netrw_winsize = 25

local opt = vim.opt

-- Line display and numbering
opt.cursorline = true                         -- Highlight current line
opt.number = true                             -- Show line numbers
opt.relativenumber = true                     -- Show relative line numbers
opt.colorcolumn = '120'                       -- Show column marker
opt.wrap = false                              -- Disable line wrapping

-- Status and command line
opt.cmdheight = 0                             -- Minimize command line height
opt.laststatus = 3                            -- Global status line
opt.showmode = false                          -- Hide mode indicator
opt.signcolumn = 'yes'                        -- Always show sign column

-- Colors and visual indicators
opt.termguicolors = true                      -- Enable true color support
opt.list = true                               -- Show invisible characters
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.smoothscroll = true                       -- Smooth scrolling

-- Scroll and viewport
opt.scrolloff = 8                             -- Keep lines visible above/below cursor
opt.sidescrolloff = 8                         -- Keep columns visible left/right
opt.winminwidth = 5                           -- Minimum window width
opt.foldlevel = 99                            -- Start with all folds open

-- Popup and completion
opt.pumblend = 10                             -- Popup menu transparency
opt.pumheight = 10                            -- Maximum popup menu height
opt.completeopt = 'menu,menuone,noselect'

opt.hlsearch = true                           -- Highlight search results
opt.ignorecase = true                         -- Case-insensitive search
opt.smartcase = true                          -- Case-sensitive if uppercase present
opt.grepformat = '%f:%l:%c:%m'                -- Grep output format
opt.grepprg = 'rg --vimgrep'                  -- Use ripgrep for searching

-- File management
opt.backup = false                            -- Disable backup files
opt.swapfile = false                          -- Disable swap files
opt.undofile = true                           -- Enable persistent undo
opt.undolevels = 10000                        -- Maximum number of changes to remember

-- Encoding
opt.encoding = 'utf-8'                        -- Internal encoding
opt.fileencoding = 'utf-8'                    -- File encoding

opt.tabstop = 4                               -- Spaces per tab
opt.shiftwidth = 4                            -- Spaces per indent
opt.softtabstop = 4                           -- Spaces per tab when editing
opt.expandtab = true                          -- Use spaces instead of tabs

opt.splitright = true                         -- Open vertical splits to the right
opt.splitbelow = true                         -- Open horizontal splits below
opt.splitkeep = 'screen'                      -- Maintain split screen position

opt.timeoutlen = 300                          -- Time to wait for mapped sequence
opt.updatetime = 200                          -- Faster completion

opt.sessionoptions = {
  'buffers',                                  -- Save buffer list
  'curdir',                                   -- Save current directory
  'tabpages',                                 -- Save tab pages
  'winsize',                                  -- Save window sizes
  'help',                                     -- Save help windows
  'globals',                                  -- Save global variables
  'skiprtp',                                  -- Don't save runtime path
  'folds'                                     -- Save folds
}