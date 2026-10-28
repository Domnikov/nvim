require("scrollbar").setup({
    set_highlights = true,

    -- Preserve diagnostic, search, and Git marks.
    providers = {
        cursor = false,
        diagnostic = true,
        search = true,
        gitsigns = true,
        ale = false,
    },

    -- Exclude terminal and prompt buffers.
    exclude = {
        buftypes = {
            terminal = true,
        },
        filetypes = {
            prompt = true,
            TelescopePrompt = true,
        },
    },

    -- Preserve your marker colors and characters.
    marks = {
        Search = {
            text = { "-", "=" },
            priority = 0,
            highlight = {
                fg = "#98c379",
            },
        },

        Error = {
            text = { "-", "=" },
            priority = 1,
            highlight = {
                fg = "#e86671",
            },
        },

        Warn = {
            text = { "-", "=" },
            priority = 2,
            highlight = {
                fg = "#d19a66",
            },
        },

        Info = {
            text = { "-", "=" },
            priority = 3,
            highlight = {
                fg = "#e5c07b",
            },
        },

        Hint = {
            text = { "-", "=" },
            priority = 4,
            highlight = {
                fg = "#c678dd",
            },
        },

        Misc = {
            text = { "-", "=" },
            priority = 5,
            highlight = {
                fg = "#c678dd",
            },
        },
    },

    scrollbar = {
        -- Display scrollbars in all eligible windows.
        visibility = "all",

        -- Preserve the original handle color and appearance.
        thumb = {
            text = " ",
            highlight = {
                bg = "#b2bbcc",
            },
            hide_if_all_visible = true,
        },

        -- Account for wrapped lines and closed folds.
        unit = "screenline",

        -- Preserve the original maximum-line behavior.
        max_lines = false,

        -- Keep rendering responsive.
        throttle_ms = 100,
    },
})
