local opt = vim.opt

-- UI and Visual Enhancements
opt.cursorline = true                       			-- Highlight current line
opt.number = true                           			-- Show line numbers
opt.relativenumber = true                   			-- Show relative line numbers
opt.colorcolumn = "120"                     			-- Show column marker at 120 characters
opt.cmdheight = 0                           			-- Minimize command line height
opt.laststatus = 3                          			-- Always show the status line
opt.signcolumn = "yes"                      			-- Always show the sign column
opt.showmode = false                        			-- Disable mode display in command line
opt.termguicolors = true                    			-- Enable true color support
opt.list = true                             			-- Show some invisible characters
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.smoothscroll = true

-- Scroll and Window Behavior
opt.scrolloff = 8                           			-- Lines to keep above and below cursor
opt.sidescrolloff = 8                       			-- Columns of context
opt.winminwidth = 5                         			-- Minimum window width
opt.foldlevel = 99

-- Popup Menu Configuration
opt.pumblend = 10                           			-- Popup menu transparency
opt.pumheight = 10                          			-- Maximum number of entries in a popup
opt.completeopt = "menu,menuone,noselect"   			-- Configure completion options

-- Search and Case Sensitivity
opt.hlsearch = true                         			-- Highlight search results
opt.ignorecase = true                       			-- Ignore case in search patterns
opt.smartcase = true                        			-- Override ignorecase if search contains uppercase
opt.grepformat = "%f:%l:%c:%m"              			-- Format for 'grep' results
opt.grepprg = "rg --vimgrep"                			-- Use ripgrep for searching

-- File Handling and Persistence
opt.backup = false                          			-- Disable backup files
opt.swapfile = false                        			-- Disable swap files
opt.encoding = "utf-8"                      			-- Set file encoding
opt.fileencoding = "utf-8"                  			-- Set file encoding (for reading/writing files)
opt.undofile = true                         			-- Enable undo file persistence
opt.undolevels = 10000                      			-- Set the number of undo levels

-- Indentation and Whitespace
opt.tabstop = 4                             			-- Set the number of spaces for a tab
opt.shiftwidth = 4                          			-- Set indentation width
opt.softtabstop = 4                         			-- Set soft tab width
opt.expandtab = true                        			-- Use spaces instead of tabs
opt.wrap = false                            			-- Disable line wrapping

-- Split and Window Management
opt.splitright = true                       			-- Split windows to the right
opt.splitbelow = true                       			-- Split windows below
opt.splitkeep = "screen"                    			-- Keep split windows' screen position

-- Timing and Responsiveness
opt.timeoutlen = 300                        			-- Set timeout length for key sequences
opt.updatetime = 200                        			-- Set time to wait before triggering events

-- Session Management
opt.sessionoptions = { 
    "buffers", "curdir", "tabpages", "winsize", 
    "help", "globals", "skiprtp", "folds" 
}