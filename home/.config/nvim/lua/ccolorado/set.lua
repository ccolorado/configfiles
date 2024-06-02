
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = 80

-- TODO: Auto resize splits|panes, when resizing window
vim.api.nvim_create_autocmd("VimResized", {
    pattern = "*",
    command = "wincmd ="
})

-- TODO: translate fat finger from vim to nvim

--   " Fat Finger {{{
-- 
--     if has("user_commands")
--       " Saving changes
--       command! -bang -nargs=? -complete=file E e<bang> <args>
--       command! -bang -nargs=? -complete=file W w<bang> <args>
--       command! -bang -nargs=? -complete=file Wq wq<bang> <args>
--       command! -bang -nargs=? -complete=file WQ wq<bang> <args>
--       command! -bang Wa wa<bang>
--       command! -bang WA wa<bang>
--       command! -bang Q q<bang>
--       command! -bang QA qa<bang>
--       command! -bang Qa qa<bang>
--       command! -bang Qall qall<bang>
-- 
--       "Vertical splitting
--       command! -nargs=? -complete=file Vsp vsp <args>
-- 
--     endif
-- 
--   " }}}



