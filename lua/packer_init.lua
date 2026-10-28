-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- For avante seatch. Delete if no need
-- pcall(require, "luarocks.loader")

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end
packer.init({
  compile_on_sync = true,
  git = {
    depth = 1, -- Only get latest commit
  },
  display = {
    open_fn = require('packer.util').float
  }
})


local use = packer.use
  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- Speed up Nvim startup
  use 'lewis6991/impatient.nvim'

  -- Comments. In visul mode <gc> for line and <gb> for block
  use 'numToStr/Comment.nvim'

  -- Icons
  use {
    'kyazdani42/nvim-web-devicons',
    requires = 'echasnovski/mini.nvim'
  }

  -- Tag viewer
  use {
    'preservim/tagbar',
    module = 'tagbar'
  }

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate"
    -- opt = true
  }

  -- Color schemes
  -- Ivan's
  use {'Mofiqul/vscode.nvim', commit = "c5125820a0915ef50f03fae10423c43dc49c66b1" }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    after = { "impatient.nvim" }
  }

  use {
    "nvimtools/none-ls.nvim",
    after = { "nvim-lspconfig" }
  }

  -- Make Neovim's fold look modern and keep high performance
  -- use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  use { --Stopped working after disabling nvim-cmp
    'hrsh7th/cmp-nvim-lsp',
    after = { "nvim-lspconfig" }
  }

  -- Autocomplete. Replace with COC
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        run = 'make install_jsregexp',
      },
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  module = 'cmp'
  }

  -- Automatically adjusts 'shiftwidth' and 'expandtab' based on the current file
  use 'tpope/vim-sleuth'

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end,
  }

  -- magit
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- prettier keymaps
  use {
    'folke/which-key.nvim',
  }

  -- fuzzy find all the things
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }

  -- Ivan
  -- Show various informatin each line
  -- Probably useless. Remove?
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
    end
  }

  -- Git blame
  -- Cannot find the same on lua
  use 'tpope/vim-fugitive'

  -- Directory nvim-treesitter
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Cmake features
  use 'Civitasv/cmake-tools.nvim'

  -- Scrollbar with search and errors
  use {
    "kevinhwang91/nvim-hlslens",
    config = function()
        require("hlslens").setup({
            calm_down = true,
            nearest_only = false,
            nearest_float_when = "never",
        })
    end,
}
  -- looks ugly. But has some use
  use {
    "petertriho/nvim-scrollbar",
    branch = "refactor/v2",
    requires = {
        "lewis6991/gitsigns.nvim",
    },
  }

  -- LSP status in statusline
  -- Looks like doesn't work. Need additional check now to make it work
  use 'nvim-lua/lsp-status.nvim'

  -- Debugging
  use {
    "nvim-telescope/telescope-dap.nvim",
    requires = {
      "mfussenegger/nvim-dap",
    }
  }
  use {
    'theHamsta/nvim-dap-virtual-text',
    after = 'nvim-treesitter',
    requires = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  }
  use {
    "rcarriga/nvim-dap-ui",
    requires = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    }
  }
  use {
  "mfussenegger/nvim-dap",
  opt = true,
  event = "BufReadPre",
  module = { "dap" },
  wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui"},
    requires = {
      "Pocco81/DAPInstall.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
      { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    },
  }


-- Open file with line number
  use 'wsdjeg/vim-fetch'

-- Fancy symbols. TODO: Change to https://github.com/stevearc/aerial.nvim
  use {
    'hedyhli/outline.nvim',
    config = function()
      require("outline").setup({})
    end,
  }

-- Tests. Need to configure better
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "alfaix/neotest-gtest",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    },
  }

  -- Nice notifications in popup windows
  use {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
    end,
  }

-- All AI related plugins
-- use 'github/copilot.vim'            -- GitHub Copilot for Neovim
use {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true },
      panel = { enabled = false },
    })
  end
}

use({
  'neoclide/coc.nvim', -- For GPT completions and interactions
  branch = 'release',
  run = 'npm ci --legacy-peer-deps',
})

use { 'jackMort/ChatGPT.nvim',      -- ChatGPT for Neovim (GPT interaction)
  requires = {
    'MunifTanjim/nui.nvim', -- required for UI components
    'nvim-lua/plenary.nvim', -- required for async operations
  },
}

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
  require('packer').sync()
end
