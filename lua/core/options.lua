-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
opt.timeoutlen = 500 -- shorter timeout for which-key

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.relativenumber = true   -- Show Relative numbers
opt.cursorline = true       -- Highlight Cursor line
opt.cursorlineopt= 'number' -- Hight onle number
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
-- opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

-----------------------------------------------------------
-- Ivan's options start
-----------------------------------------------------------
opt.wrap = false         -- No wrap text

-- Build options options
opt.makeprg = [[make]]

-- Mark tabs, dungling spaces and end of lines
opt.listchars = { tab = '▶ ', trail = '·', extends = '↵', nbsp = '.' }
opt.list = true

--desable unused providers
g.loaded_perl_provider = 0

-- Use system clipboard
g.clipboard = {
    name = 'myClipboard',
    copy = {
        ["+"] = {'my_vim_copy.sh'},
        ["*"] = {'my_vim_copy.sh'},
    },
    paste = {
        ["+"] = {'my_vim_paste.sh'},
        ["*"] = {'my_vim_paste.sh'},
    },
    cache_enabled = 1,
}

vim.api.nvim_set_option("clipboard","unnamedplus")

-- disable swap
opt.swapfile = false

-- use unix file format
opt.fileformat = 'unix'
opt.fileformats = {'unix'}

-- highlight options
vim.cmd('hi LineNr guifg=Lime')
vim.cmd('hi CursorLineNR guifg=Orange')

-- Disable Ruby provider
g.loaded_ruby_provider = 0

-- Terminal scroll size
opt.scrollback = 100000
-----------------------------------------------------------
-- Ivan's options end
-----------------------------------------------------------


-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end


