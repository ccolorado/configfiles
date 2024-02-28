-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local builtin = require('telescope.builtin')

-- pROJECT fIND (find in all files in proyect ?
--  directory or opened buffers ? idklol
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Filter find git files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Find in file contents
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep in files >") })
end)

