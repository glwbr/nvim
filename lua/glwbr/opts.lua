-- Shortcuts
local g = vim.g
local opt = vim.opt

-- Display Settings
opt.termguicolors = true                            -- Enable true color support
opt.background = 'dark'                             -- Set dark color theme
opt.cursorline = true                               -- Highlight the current cursor line
opt.colorcolumn = '120'                             -- Highlight column for line length guidance
opt.wrap = false                                    -- Disable automatic text wrapping

-- Line Numbers
opt.number = true                                   -- Show absolute line number for current line
opt.relativenumber = true                           -- Show relative line numbers for other lines

-- Invisible Characters
opt.list = true                                     -- Show invisible characters
opt.listchars = {                                   -- Define how invisible characters appear
  tab = '› ',                                       -- Tab character
  trail = '·',                                      -- Trailing spaces
  extends = '…',                                    -- Line continues beyond screen
  precedes = '…',                                   -- Line continues before screen
  nbsp = '␣',                                       -- Non-breaking space
}

-- Fill Characters
opt.fillchars = {
  foldopen = "",                                   -- Symbol for open fold
  foldclose = "",                                  -- Symbol for closed fold
  fold = " ",                                       -- Fill character for folds
  foldsep = " ",                                    -- Fold separator
  diff = "╱",                                       -- Diff mode separator
  eob = " ",                                        -- Empty line indicator
}

-- Command Line & Status
opt.cmdheight = 0                                   -- Hide command line when not in use
opt.laststatus = 3                                  -- Use global status line
opt.showmode = false                                -- Hide mode indicator (handled by statusline plugin)
opt.signcolumn = 'yes'                              -- Always show sign column for diagnostics/git markers

-- Scrolling Behavior
opt.smoothscroll = true                             -- Enable pixel-based smooth scrolling
opt.scrolloff = 8                                   -- Minimum lines to keep above/below cursor
opt.sidescrolloff = 8                               -- Minimum columns to keep left/right of cursor

-- Split Preferences
opt.splitright = true                               -- New vertical splits open to the right
opt.splitbelow = true                               -- New horizontal splits open below
opt.splitkeep = 'screen'                            -- Keep text in same screen position when splitting
opt.winminwidth = 5                                 -- Minimum width of non-current windows

-- Cursor Configuration
opt.guicursor = {
  'n-v-c:block',                                    -- Block cursor in normal, visual, command modes
  'i-ci-ve:ver25',                                  -- 25% width vertical bar in insert modes
  'r-cr:hor20',                                     -- 20% height horizontal bar in replace modes
  'o:hor50',                                        -- 50% height horizontal bar in operator-pending mode
  'a:blinkwait700-blinkoff400-blinkon250',          -- Blink timing for all modes
  'sm:block-blinkwait175-blinkoff150-blinkon175',   -- Selection mode cursor with faster blink
}

-- Terminal Undercurl Support
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Search Settings
opt.hlsearch = true                                 -- Highlight search matches
opt.ignorecase = true                               -- Ignore case when searching
opt.smartcase = true                                -- Override ignorecase when uppercase is used
opt.grepprg = 'rg --vimgrep'                        -- Use ripgrep for external search
opt.grepformat = '%f:%l:%c:%m'                      -- Format for grep output parsing

-- Completion Menu
-- opt.pumblend = 10                                   -- Slight transparency for popup menu
-- opt.pumheight = 10                                  -- Limit height of popup menu
opt.completeopt = 'menu,menuone,noselect'           -- Completion behavior options

-- Indentation & Text Formatting
opt.tabstop = 4                                     -- Width of a tab character
opt.shiftwidth = 4                                  -- Spaces for each indentation level
opt.softtabstop = 4                                 -- Spaces inserted when pressing Tab
opt.expandtab = true                                -- Convert tabs to spaces when inserted

-- File Handling
opt.backup = false                                  -- Don't create backup files
opt.swapfile = false                                -- Don't use swap files
opt.undofile = true                                 -- Enable persistent undo history
opt.undolevels = 10000                              -- Store this many undo changes
opt.encoding = 'utf-8'                              -- Internal encoding
opt.fileencoding = 'utf-8'                          -- Default file encoding

-- Folding
opt.foldmethod = 'expr'                             -- Use expression for folding
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'    -- Use treesitter for intelligent folding
opt.foldlevel = 99                                  -- Start with all folds open

-- Performance & Timing
opt.timeoutlen = 300                                -- Time to wait for key mapping completion (ms)
opt.updatetime = 200                                -- Faster CursorHold events and auto-saves

-- Session Management
opt.sessionoptions = {
  'buffers',                                        -- Save buffer list
  'curdir',                                         -- Save current directory
  'winsize',                                        -- Save window sizes
  'help',                                           -- Save help windows
  'globals',                                        -- Save global variables
  'skiprtp',                                        -- Don't save runtime path
  'folds',                                          -- Save folds
}

-- Netrw Settings
g.netrw_banner = 0                                  -- Hide banner
g.netrw_browse_split = 0                            -- Open files in current window
g.netrw_sort_by = 'name'                            -- Sort files by name
g.netrw_winsize = 25                                -- Set explorer to 25% of window width

-- Language & Spelling
opt.spelllang = { 'en' }                            -- Set spelling language to English

-- local hour = os.date('*t').hour
-- vim.o.background = (hour >= 7 and hour < 19) and 'light' or 'dark'
