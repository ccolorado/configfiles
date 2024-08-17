return {
  -- save as sudo
  vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee > /dev/null %', { noremap = true, silent = true }),

  -- Git
  -- TODO: search helpers for
  --  * change branch, * pull , * push

  -- -- gitsigns
  --
  -- -- fugitive
  vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>'),
  vim.keymap.set('n', '<Leader>gb', ':G blame<CR>'),

  -- using neogit's instead
  -- vim.keymap.set('n', '<Leader>gs', ':Git<CR>'),

  vim.keymap.set('n', '<Leader>gc', ':G commit<CR>'), -- commits staged only

  -- `:Git mergetool`
  -- `:Git difftool`
  --
  -- vim.keymap.set('n', '<Leader>gtm', ':G difftool<CR>'),
  -- vim.keymap.set('n', '<Leader>gtd', ':G mergetool<CR>'),

  -- -- neogit
  vim.keymap.set('n', '<Leader>gs', ':Neogit<CR>', { silent = true, noremap = true }),
}
