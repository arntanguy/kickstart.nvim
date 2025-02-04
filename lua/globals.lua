-- load .nvim.lua per-project after init.lua
-- see :help exrc
vim.opt.exrc = true

-- Hide neovim's command line by default
vim.o.cmdheight = 0

-- Use ESC to exit the terminal prompt 
vim.cmd [[
au TermOpen * tnoremap <Esc><Esc> <c-\><c-n>
au FileType fzf tunmap <Esc><Esc>
]]

P = function(v)
  vim.print(v)
  return v
end

RELOAD=function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

-- Should only exist on lua files
vim.keymap.set('n', '<leader><leader>x', ':write<CR>:source<CR>', { desc = 'Save and source current file' })
vim.keymap.set('n', '<leader>t', '<Plug>PlanaryTestFile', { desc = 'Run test file using plenary' })
