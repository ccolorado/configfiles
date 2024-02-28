vim.g.mapleader = " "

-- Open directory Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move visual selection(?) one up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Like `j` that concatenates lines, but keeps the cursor in-place
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll up and down while keeping the cursor vertically centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search Next and previous while keeping the cursor vertically centered
-- Not sure if I want to keep these
-- TODO: evaluate how I feell about these mappings
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Past highlighted selection in place without replacing void register with 
-- replaced text.
-- TODO: evaluate how I feell about these mappings
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Tmux session switch ??? really interesting (requires some tmux tinkering)
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- no idae
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Copy selection(?) to system clipbaord
-- `y` for vim's clibpard, <leader>y to system's clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")


-- Populaes search/replace prompt with word under cursor
-- e.g. %s/THE_WORD/THE_WORD/g
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Makes current file executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })








