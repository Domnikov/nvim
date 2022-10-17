require("nvim-dap-virtual-text").setup {
  show_stop_reason = true,
}
require("dapui").setup()

local dap, dapui = require('dap'), require('dapui')
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

--dap.set_log_level('TRACE');

dap.adapters.lldbvscode = {
    type = 'executable',
    attach = {pidProperty = "pid", pidSelect = "ask"},
    command = 'lldb-vscode',
    name = "lldbvscode",
    --env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"}
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldbvscode",
        request = "launch",
--        program = function()
--            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
--                                'file')
--        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        showDisassembly = "never",
        program = '',
        args = {''},

        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        runInTerminal = false,
    }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp


