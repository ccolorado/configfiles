
-- Force focus detection
vim.g.gitgutter_terminal_reports_focus = 0

-- Force diffs to run asynchronously.
vim.g.gitgutter_async = 1

-- default value (Vim < 8.1.0614, Neovim < 0.4.0)
vim.g.gitgutter_max_signs = 500  

-- hunk motions
-- vim.keymap.set("n", "]h", "<Plug>(GitGutterNextHunk)")
vim.keymap.set("n", "]h", "<cmd>GitGutterNextHunk<CR>")
vim.keymap.set("n", "[h", "<cmd>GitGutterPrevHunk<CR>")

-- Customize keystrokes, hunk {add, remove, preview}
-- Stages changes under cursor
vim.keymap.set("n", "<Leader>ha", "<cmd>GitGutterStageHunk<CR>")
-- De-stages changes under cursor
vim.keymap.set("n", "<Leader>hr", "<cmd>GitGutterUndoHunk<CR>")
-- no idea XD
vim.keymap.set("n", "<Leader>hv", "<cmd>GitGutterPreviewHunk<CR>")

-- With Neovim 0.3.2 or higher, you can turn line number highlighting on and off (defaults to off):
-- turn on with :GitGutterLineNrHighlightsEnable
-- turn off with :GitGutterLineNrHighlightsDisable
-- toggle with :GitGutterLineNrHighlightsToggle.
