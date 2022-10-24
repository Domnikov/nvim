local wk = require('which-key')
local h = require('helpers/misc')

wk.setup({})

function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true,true)
end

wk.register({
  g = {
    name = "Go to...",
    d = {h.cmdify("lua vim.lsp.buf.declaration()"), "Goto Declation"},
    D = {h.cmdify("lua vim.lsp.buf.definition()"), "Goto Defenition"},
    f = {h.cmdify("lua vim.lsp.buf.definition()"), "Goto File"},
    h = {h.cmdify('lua vim.lsp.buf.hover()'), "Hover"},
    i = {h.cmdify('lua vim.lsp.buf.implementation()'), "Implementation"},
    T = {h.cmdify('lua vim.lsp.buf.type_definition()'), "Type definition"},
    r = {h.cmdify('lua vim.lsp.buf.references()'), "References"},
  },
  ["<space>"] = {
    ["<space>"] = {h.cmdify(" " ..
      ":lua require('telescope.builtin').find_files(" ..
        "{search_dirs={" ..
          "'add_new_dir_here'," ..
          "'and_here'," ..
          "'.'" ..
        "}, require('telescope.themes').get_dropdown{previewer = false}})"), "Find Files"},

    b = {h.cmdify("Telescope buffers"), "Buffers"},
    h = {h.cmdify("Telescope command_history"), "History"},
    f = {
      name = "Files...",
      f = {h.cmdify("Telescope find_files"), "File Browser"},
      l = {h.cmdify("Telescope live_grep"), "Live Grep"},
      t = {h.cmdify("NvimTreeToggle"), "Open Tree"}
    },
    c = {
      name = "Code...",
      s = {h.cmdify("Telescope lsp_document_symbols"), "Show All Symbols"};
      i = {h.cmdify("lua vim.lsp.buf.hover()"), "Show Information"};
      l = {h.cmdify("Telescope colorscheme"), "Tags"};
      t = {h.cmdify("Telescope tags"), "Tags"};
      u = {h.cmdify("Trouble lsp_references"), "Show Usage"},
      a = {h.cmdify('lua vim.lsp.buf.code_action()'), "LSP code action"},
      f = {h.cmdify('lua vim.lsp.buf.formatting()'), "LSP Format"},
      r = {
        name = "Refactor...",
        r = {h.cmdify('lua vim.lsp.buf.rename()'), "Rename symbol" },
      },
    },
    d = {
      name = "Debug",
      f = {h.cmdify("Telescope dap frames"), "Frames"};
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    },
    D = {
      name = "Diagnostics...",
      d = {h.cmdify('lua vim.diagnostic.open_float()'), "Line diagnostics"},
      n = {h.cmdify('lua vim.lsp.diagnostic.goto_next()'), "Next"},
      p = {h.cmdify('lua vim.lsp.diagnostic.goto_prev()'), "Previous"},
      l = {h.cmdify('lua vim.diagnostic.setloclist()'), "Set loclist"},
    },
    t = {
      name = "Terminal...",
      t = {h.cmdify("ToggleTerm"), "Toggle Terminal"}
    },
    g = {
      name = "Git...",
      b = {h.cmdify('Git blame'), 'Blame File'},
      g = {h.cmdify('Neogit'), 'Neogit'},
      l = {h.cmdify('Gitsigns blame_line'), 'Blame Line'},
      p = {h.cmdify('Gitsigns preview_hunk'), 'Preview Hunk'},
      s = {h.cmdify('Telescope git_status'), 'Status'}
    },
    m = {
      name = "Making...",
      m = {"<cmd>opt.makeprg = 'build cpsfttest'", 'Cpsfttest'},
    },
  }
})

wk.register({["<esc>"] = {termcodes([[<C-\><C-n>]]), "Exit insert mode"}}, {mode = 't'})

