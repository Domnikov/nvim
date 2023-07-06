local in_vscode = require('helpers/misc').in_vscode

require('packer_init')
require('impatient')

require('core/autocmds')
require('plugins/kommentary')

if not in_vscode() then
  require('plugins/colorscheme')
  require('plugins/which-key')
  require('plugins/nvim-treesitter')
  require('plugins/nvim-lspconfig')
  require('plugins/lualine')
  require('plugins/telescope')
--  require('plugins/toggleterm')
--  require('plugins/indent-blankline') Removed by Ivan because it's bothiring him
-- Ivan's
  require('plugins/trouble')
  require('plugins/nvim-tree')
  require('plugins/nvim-scrollbar')
  require('plugins/nvim-ufo')
  require('plugins/nvim-dap')
end

require('core/options')
