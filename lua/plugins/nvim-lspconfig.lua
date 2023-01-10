-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

-- Enable for debugging
-- vim.lsp.set_log_level("debug")

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

-- Replace some simbols
vim.fn.sign_define(
  "DiagnosticSignError",
  { texthl = "DiagnosticSignError", text = "⛔", numhl = "DiagnosticSignError" }
)
vim.fn.sign_define(
  "DiagnosticSignWarning",
  { texthl = "DiagnosticSignWarning", text = "🟡", numhl = "DiagnosticSignWarning" }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  { texthl = "DiagnosticSignHint", text = "💡", numhl = "DiagnosticSignHint" }
)
vim.fn.sign_define(
  "DiagnosticSignInformation",
  { texthl = "DiagnosticSignInformation", text = "🟢", numhl = "DiagnosticSignInformation" }
)

-- Diagnostic options, see: `:help vim.diagnostic.config`
vim.diagnostic.config({ virtual_text = true })

-- Show line diagnostics automatically in hover window
vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]])

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Highlighting references
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--  local cmdify = require('helpers/misc').cmdify
--  require('which-key').register({
--    g = {
--      name = "Go to...",
--      D = { cmdify('lua vim.lsp.buf.declaration()'), "Declaration"},
--      d = { cmdify('lua vim.lsp.buf.definition()'), "Definition"},
--      h = { cmdify('lua vim.lsp.buf.hover()'), "Hover"},
--      i = { cmdify('lua vim.lsp.buf.implementation()'), "Implementation"},
--      T = { cmdify('lua vim.lsp.buf.type_definition()'), "Type definition"},
--      r = { cmdify('lua vim.lsp.buf.references()'), "References"},
--    },
--    ["<space>"] = {
--      c = {
--        name = "Code...",
--        a = { cmdify('lua vim.lsp.buf.code_action()'), "LSP code action"},
--        f = { cmdify('lua vim.lsp.buf.formatting()'), "LSP Format"},
--        r = {
--          name = "Refactor...",
--          r = { cmdify('lua vim.lsp.buf.rename()'), "Rename symbol" },
--        },
--      },
--      d = {
--        name = "Diagnostics...",
--        d = { cmdify('lua vim.diagnostic.open_float()'), "Line diagnostics"},
--        n = { cmdify('lua vim.lsp.diagnostic.goto_next()'), "Next"},
--        p = { cmdify('lua vim.lsp.diagnostic.goto_prev()'), "Previous"},
--        l = { cmdify('lua vim.diagnostic.setloclist()'), "Set loclist"},
--      },
--    },
--  }, {
--    buffer = bufnr
--  })
end

--[[

Language servers setup:

For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

Bash --> bashls
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls

Python --> pyright
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright

C-C++ --> clangd
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd

HTML/CSS/JSON --> vscode-html-languageserver
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html

JavaScript/TypeScript --> tsserver
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver

--]]

-- Define `root_dir` when needed
-- See: https://github.com/neovim/nvim-lspconfig/issues/320
-- This is a workaround, maybe not work with some servers.
local root_dir = function()
  return vim.fn.getcwd()
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:
local servers = { 'bashls', 'pyright', 'html', 'cssls', 'clangd', 'tsserver' }

-- Call setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    root_dir = root_dir,
    capabilities = capabilities,
    flags = {
      -- default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- lspconfig['ccls'].setup {
--   cmd = { "ccls" };
--   on_attach = on_attach,
--   root_dir = root_dir,
--   capabilities = capabilities,
--   init_options = {
--     cache = {
--       compilationDatabaseDirectory = ".";
--       directory = "~/.cache/ccls";
--     };
--     clang = {
--       extraArgs = {"-std=c++17"};
--     };
--     index = {
--       blacklist = {"."};
--       threads = 16;
--       timeout = 500000;
--       whitelist = {
--         ".",
--         "."
--       };
--     };
--     request = {
--       timeout = 500000;
--     };
--   }
-- }

require'lspconfig'.clangd.setup{
  cmd = { "clangd",
     "-j=10",
     "--log=error",
     "--background-index",
     "--clang-tidy",
     "--completion-style=bundled",
     "--header-insertion=never",
     -- "--compile-commands-dir=.",
     "--query-driver=q++"
   };
}

-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- url: https://github.com/hrsh7th/nvim-cmpa


local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_status_ok then
  return
end

cmp.setup {
  -- Load snippet support
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

-- Completion settings
  completion = {
    --completeopt = 'menu,menuone,noselect'
    keyword_length = 2
  },

  -- Key mapping
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- Tab mapping
    ['<Down>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<Up>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end
  },

  -- Load sources, see: https://github.com/topics/nvim-cmp
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}


