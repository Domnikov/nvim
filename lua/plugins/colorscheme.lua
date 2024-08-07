-- Ivan's
vim.o.background = 'dark'
local c = require('vscode.colors')
require('vscode').setup({
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        vscLineNumber = '#FFFFFF',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    }
})

-- Markus's
--local g  = vim.g
--
--g.gruvbox_material_foreground = 'original'
--g.gruvbox_material_enable_bold = 1
--g.gruvbox_material_diagnostic_line_highlight = 1
--g.gruvbox_material_statusline_style = 'original'
--
--vim.opt.background = "dark"
--vim.opt.cursorline = true
--vim.cmd([[colorscheme gruvbox-material]])


