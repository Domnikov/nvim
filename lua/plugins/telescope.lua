local actions = require("telescope.actions")
local telescope = require('telescope')
telescope.setup({
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--ignore-file',
      '~/sources/.ignore'
    },
    path_display={"truncate"},
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    }
  },
  pickers = {
    live_grep = {
        additional_args = function(opts)
          return {"-u", "-Txml"}
        end
      },
    },
  })

