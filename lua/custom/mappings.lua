return {
  -- save as sudo
  vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee > /dev/null %', { noremap = true, silent = true }),

  -- Terminals
  -- :ToggleTerm direction=float
  vim.keymap.set('n', '<Leader>ttf', ':ToggleTerm direction=float<CR>'),
  vim.keymap.set('n', '<Leader>ttv', ':ToggleTerm direction=vertical<CR>'),
  vim.keymap.set('n', '<Leader>tth', ':ToggleTerm direction=horizontal<CR>'),

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

  vim.keymap.set('n', '<Leader>gm', ':GMove '), -- prompts GMove requries destinantion path
  vim.keymap.set('n', '<Leader>gc', ':G commit<CR>'), -- commits staged only

  -- `:Git mergetool`
  -- `:Git difftool`
  --  hunks @ init lua
  -- vim.keymap.set('n', '<Leader>gtm', ':G difftool<CR>'),
  -- vim.keymap.set('n', '<Leader>gtd', ':G mergetool<CR>'),

  -- -- neogit
  vim.keymap.set('n', '<Leader>gs', ':Neogit<CR>', { silent = true, noremap = true }), -- floating maybe ?

  -- vim.keymap.set('n', '<Leader>f', '<cmd>NvimTreeToggle<CR>'),
  vim.keymap.set('n', '<Leader>f', '<cmd>Neotree toggle<CR>'),

  -- vim.cmd("iabbrev <expr> ,d strftime('%Y-%m-%d')")
}
