local wk = require('which-key')
local h = require('helpers/misc')

wk.setup({})

function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true,true)
end

function is_vcc_dhu()
  local template = "/home/ivan/sources/volvocars-dhu"
  local path = string.sub(vim.fn.getcwd(), 0, string.len(template))
  return path == template
end

function is_ht_dhu()
  local template = "/home/ivan/sources/haleytek-dhu"
  local path = string.sub(vim.fn.getcwd(), 0, string.len(template))
  return path == template
end

function is_vcc_uxc()
  local template = "/home/ivan/sources/volvocars-uxc"
  local path = string.sub(vim.fn.getcwd(), 0, string.len(template))
  return path == template
end

function is_vcc_any()
  return is_vcc_dhu() or is_vcc_uxc()
end

function is_ht_any()
  return is_ht_dhu() or is_ht_uxc()
end

function is_ht_uxc()
  local template = "/home/ivan/sources/haleytek-uxc"
  local path = string.sub(vim.fn.getcwd(), 0, string.len(template))
  return path == template
end

function is_work_source()
  return is_vcc_any() or is_ht_any()
end

function is_aoc_source()
  local template = "/home/ivan/sources/advent_of_code"
  local path = string.sub(vim.fn.getcwd(), 0, string.len(template))
  return path == template
end

function is_any_source()
  return is_work_source() or is_aoc_source()
end

wk.add({
  { "<space><space>", "<cmd> :lua require('telescope.builtin').find_files({search_dirs={'disabled_android','.','disabled_tools'}, layout_config={height=0.99, width=0.99}})<cr>", desc = "Find Files" },
  { "<space>D", group = "Diagnostics..." },
  { "<space>Dd", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Line diagnostics" },
  { "<space>Dl", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Set loclist" },
  { "<space>Dn", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", desc = "Next" },
  { "<space>Dp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", desc = "Previous" },
  { "<space>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<space>c", group = "Code..." },
  { "<space>cS", "<cmd>SymbolsOutline<cr>", desc = "Open Symbols Panel" },
  { "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "LSP code action" },
  { "<space>cf", "<cmd>lua vim.lsp.buf.formatting()<cr>", desc = "LSP Format" },
  { "<space>ci", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show Information" },
  { "<space>cl", "<cmd>Telescope colorscheme<cr>", desc = "Tags" },
  { "<space>cr", group = "Refactor..." },
  { "<space>crr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename symbol" },
  { "<space>cs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Show All Symbols" },
  { "<space>ct", "<cmd>Telescope tags<cr>", desc = "Tags" },
  { "<space>cu", "<cmd>Trouble lsp_references<cr>", desc = "Show Usage" },
  { "<space>d", group = "Debug..." },
  { "<space>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", desc = "Conditional Breakpoint" },
  { "<space>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", desc = "Evaluate Input" },
  { "<space>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run to Cursor" },
  { "<space>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", desc = "Scopes" },
  { "<space>dU", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI" },
  { "<space>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
  { "<space>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
  { "<space>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
  { "<space>de", "<cmd>lua require'dapui'.eval()<cr>", desc = "Evaluate" },
  { "<space>df", "<cmd>Telescope dap frames<cr>", desc = "Frames" },
  { "<space>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
  { "<space>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", desc = "Hover Variables" },
  { "<space>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
  { "<space>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
  { "<space>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", desc = "Pause" },
  { "<space>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
  { "<space>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
  { "<space>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
  { "<space>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
  { "<space>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
  { "<space>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate" },
  { "<space>f", group = "Files..." },
  { "<space>fL", "<cmd>lua require('telescope.builtin').grep_string({layout_strategy='vertical',layout_config={height=0.99,width=0.99}})<cr>", desc = "Grep String" },
  { "<space>ff", "<cmd>Telescope find_files<cr>", desc = "File Browser" },
  { "<space>fl", "<cmd>lua require('telescope.builtin').live_grep({default_text = vim.fn.expand('<cword>'),layout_strategy='vertical',layout_config={height=0.99,width=0.99}})<cr>", desc = "Live Grep" },
  { "<space>ft", "<cmd>NvimTreeFindFileToggle!<cr>", desc = "Open Tree" },
  { "<space>g", group = "Git..." },
  { "<space>gb", "<cmd>Git blame<cr>", desc = "Blame File" },
  { "<space>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
  { "<space>gl", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
  { "<space>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
  { "<space>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
  { "<space>p", group = "Player..." },
  { "<space>pp", "<cmd>Player play/pause<cr>", desc = "Play/Pause" },
  { "<space>ps", "<cmd>Player stop<cr>", desc = "Stop" },
  { "<space>pn", "<cmd>Player next<cr>", desc = "Next" },
  { "<space>pb", "<cmd>Player prev<cr>", desc = "Before" },
  { "<space>pw", "<cmd>Player show<cr>", desc = "Show" },
  { "<space>ph", group = "Player Shuffle..." },
  { "<space>phn", "<cmd>Player shuffle on<cr>", desc = "Shuffle On" },
  { "<space>phf", "<cmd>Player shuffle off<cr>", desc = "Shuffle Off" },
  { "<space>v", group = "Vendor Source Code Tools...", cond = is_any_source},
  { "<space>vF", "<cmd>:term compile_command_selector flash_all<cr>", desc = "Flash ALL", cond = is_vcc_dhu },
  { "<space>vI", "<cmd>:term compile_command_selector ihu_make_clean<cr>", desc = "Ihu Make QNX With Clean", cond = is_vcc_any},
  { "<space>vd", "<cmd>:term compile_command_selector moose_dl<cr>", desc = "Download", cond = is_vcc_any},
  { "<space>vc", "<cmd>:term compile_command_selector clean<cr>", desc = "Clean", cond = is_ht_dhu},
  { "<space>ve", "<cmd>:term error_menu ~/build.out<cr>", desc = "Show Errors", cond = is_any_source},
  { "<space>vf", "<cmd>:term compile_command_selector flash<cr>", desc = "Flash QNX", cond = is_vcc_dhu},
  { "<space>vi", "<cmd>:term compile_command_selector ihu_make<cr>", desc = "Ihu Make QNX", cond = is_vcc_any},
  { "<space>vm", "<cmd>:term compile_command_selector make<cr>", desc = "Make", cond = is_work_source},
  { "<space>vt", group = "Testing...", cond = is_vcc_dhu},
  { "<space>vta", "<cmd>:term compile_command_selector test-chimes-all<cr>", desc = "Test All Chimes", cond = is_vcc_dhu},
  { "<space>vte", "<cmd>:term compile_command_selector test-chimes-ext<cr>", desc = "Test Exterior Chimes", cond = is_vcc_dhu},
  { "<space>vti", "<cmd>:term compile_command_selector test-chimes-int<cr>", desc = "Test Interior Chimes", cond = is_vcc_dhu},
  { "<space>vu", "<cmd>:term compile_command_selector ut<cr>", desc = "Unit Tests", cond = is_work_source},
  { "<space>vm", "<cmd>:term [[ \"$PWD\" =~ \"advent_of_code/202\" ]] && bash -c 'echo \"AoC detected\" && git add . && git commit --allow-empty -m \"REAL RUN: $(date)\" && rm -rf ./build && cmake -B ./build && cmake --build ./build && ./build/app' 2>&1 | tee /home/ivan/build.out || echo \"error: AoC ditectory is not detected\"; error_menu ~/build.out <cr>", desc = "Run", cond = is_aoc_source},
  { "<space>vu", "<cmd>:term [[ \"$PWD\" =~ \"advent_of_code/202\" ]] && bash -c 'echo \"AoC detected\" && git add . && git commit --allow-empty -m \"TEST RUN: $(date)\" && rm -rf ./build && cmake -B ./build -DTEST= && cmake --build ./build && ./build/app' 2>&1 | tee /home/ivan/build.out || echo \"error: AoC ditectory is not detected\"; error_menu ~/build.out <cr>", desc = "Test", cond = is_aoc_source},
  { "g", group = "Go to..." },
  { "gD", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Goto Defenition" },
  { "gT", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "Type definition" },
  { "gd", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Goto Declation" },
  { "gf", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Goto File" },
  { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover" },
  { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Implementation" },
  { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References" },
})


-- wk.register({["<esc>"] = {termcodes([[<C-\><C-n>]]), "Exit insert mode"}}, {mode = 't'})

