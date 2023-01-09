local actions = require("telescope.actions")
local telescope = require('telescope')
telescope.setup({
  defaults = {
    path_display={"truncate"};
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    }
  },
  pickers = {
    live_grep = {
        additional_args = function(opts)
          return {"-uuu"}
        end
      },
    },
  })

