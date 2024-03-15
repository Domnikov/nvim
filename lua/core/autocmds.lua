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
            -- local orig_sum = vim.fn.system('md5sum '..vim.fn.expand('%').." | cut -d ' ' -f 1")
            vim.cmd("silent !format-file '%'")
            -- local new_sum = vim.fn.system('md5sum '..vim.fn.expand('%').." | cut -d ' ' -f 1")
            -- if( orig_sum == new_sum )
            -- then
               -- print("Checksums are equal: ",orig_sum," and ",new_sum)
            -- else
               -- print("Checksums aren't equal: ",orig_sum," and ",new_sum)
               -- vim.cmd("edit")
            -- end
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
