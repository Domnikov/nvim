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
      ":lua " ..
      "require('telescope.builtin')." ..
      "find_files(" ..
      "{search_dirs={" ..
        "'disabled_android'," ..
        "'.'," ..
        "'disabled_tools'}, " ..
        -- "no_ignore=true," ..
      "layout_config={height=0.99, width=0.99}})"
      ), "Find Files"},

    a = {
      name = "AdventOfCode Tools",
      t = {h.cmdify(":term [[ \"$PWD\" =~ \"AoC_202\" ]] && bash -c 'echo \"AoC detected\" && git add . && git commit --allow-empty -m \"TEST RUN: $(date)\" && rm -rf ./build && cmake -B ./build -DTEST= && cmake --build ./build && ./build/app' 2>&1 | tee /home/ivan/build.out || echo \"error: AoC ditectory is not detected\"; error_menu"), 'Test'},
      r = {h.cmdify(":term [[ \"$PWD\" =~ \"AoC_202\" ]] && bash -c 'echo \"AoC detected\" && git add . && git commit --allow-empty -m \"REAL RUN: $(date)\" && rm -rf ./build && cmake -B ./build && cmake --build ./build && ./build/app' 2>&1 | tee /home/ivan/build.out || echo \"error: AoC ditectory is not detected\"; error_menu"), 'Run'},
    },
    b = {h.cmdify("Telescope buffers"), "Buffers"},
    f = {
      name = "Files...",
      f = {h.cmdify("Telescope find_files"), "File Browser"},
      l = {h.cmdify("lua require('telescope.builtin').live_grep({default_text = vim.fn.expand('<cword>'),layout_strategy='vertical',layout_config={height=0.99,width=0.99}})"), "Live Grep"},
      L = {h.cmdify("lua require('telescope.builtin').grep_string({layout_strategy='vertical',layout_config={height=0.99,width=0.99}})"), "Grep String"},
      t = {h.cmdify("NvimTreeFindFileToggle!"), "Open Tree"}
    },
    c = {
      name = "Code...",
      s = {h.cmdify("Telescope lsp_document_symbols"), "Show All Symbols"};
      S = {h.cmdify("SymbolsOutline"), "Open Symbols Panel"};
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
    -- t = {
    --   name = "Terminal...",
    --   t = {h.cmdify("ToggleTerm"), "Toggle Terminal"}
    -- },
    g = {
      name = "Git...",
      b = {h.cmdify('Git blame'), 'Blame File'},
      g = {h.cmdify('Neogit'), 'Neogit'},
      l = {h.cmdify('Gitsigns blame_line'), 'Blame Line'},
      p = {h.cmdify('Gitsigns preview_hunk'), 'Preview Hunk'},
      s = {h.cmdify('Telescope git_status'), 'Status'}
    },
    h = {
      name = "HT Tools",
      c = {h.cmdify(":term dhu-ht-clean"), 'Clean'},
      e = {h.cmdify(":term error_menu"), 'Show Errors'},
      M = {h.cmdify(":term dhu-ht-make"), 'Make'},
    },
    v = {
      name = "VCC Tools",
      M = {h.cmdify(":term dhu-vcc-make"), 'Make'},
      e = {h.cmdify(":term error_menu"), 'Show Errors'},
      i = {h.cmdify(":term dhu-vcc-ihu_make_no_clean"), 'Ihu Make QNX'},
      I = {h.cmdify(":term dhu-vcc-ihu_make"), 'Ihu Make QNX With Clean'},
      f = {h.cmdify(":term dhu-vcc-flash"), 'Flash QNX'},
      F = {h.cmdify(":term dhu-vcc-flash_all"), 'Flash ALL'},
      m = {h.cmdify(":term dhu-vcc-ut-and-make"), 'Ut and Make'},
      d = {h.cmdify(":term dhu-vcc-moose_dl"), 'Download'},
      u = {h.cmdify(":term dhu-vcc-ut"), 'Unit Tests'},
      U = {h.cmdify(":term dhu-vcc-ut_sequence"), 'Unit Tests in Sequence'},
      t = {
        name = "Testing...",
        a = {h.cmdify(":term dhu-vcc-test-chimes-all"), 'Test All Chimes'},
        e = {h.cmdify(":term dhu-vcc-test-chimes-ext"), 'Test Exterior Chimes'},
        i = {h.cmdify(":term dhu-vcc-test-chimes-int"), 'Test Interior Chimes'},
      },
    },
  }
})

wk.register({["<esc>"] = {termcodes([[<C-\><C-n>]]), "Exit insert mode"}}, {mode = 't'})

