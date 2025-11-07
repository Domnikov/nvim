-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '250' })
  end
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '*',
  command = ":%s/\\s\\+$//e"
})

-- Format using volvo commit-check
augroup("AutoFormat", { clear = true })
autocmd(
    "BufWritePost",
    {
        pattern = {"*.hpp", "*.cpp", "*.h", "*.c", "*.cc", "*CMakeLists.txt", "*.cmake"},
        group = "AutoFormat",
        callback = function()
            vim.cmd("silent !format-file '%'")
        end,
    }
)
-- Don't auto commenting new lines
autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o'
})

-- Settings for filetypes:
-- Disable line length marker
augroup('setLineLength', { clear = true })
autocmd('Filetype', {
  group = 'setLineLength',
  pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
  command = 'setlocal cc=0'
})

-- Terminal settings:
-- Open a Terminal on the right tab
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

-- Create compile_commands file
autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local compile_script = vim.fn.expand("~/local/bin/update_all_compile_commands")
    if vim.fn.executable(compile_script) == 1 then
      vim.fn.jobstart({ compile_script }, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
          if data then
            -- vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
          end
        end,
        on_stderr = function(_, data)
          if data then
            vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
          end
        end,
      })
    else
      vim.notify("merge_compile_commands.sh not found or not executable", vim.log.levels.ERROR)
    end
  end,
})

