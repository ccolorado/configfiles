return {
  -- save as sudo
  vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee > /dev/null %', { noremap = true, silent = true }),

  -- Terminals
  -- :ToggleTerm direction=float
  vim.keymap.set('n', '<Leader>tt', ':ToggleTerm direction=float<CR>', { desc = 'Open floating termianl' }),
  vim.keymap.set('n', '<Leader>ttv', ':ToggleTerm direction=vertical<CR>', { desc = 'Open vertical termianl' }),
  vim.keymap.set('n', '<Leader>tth', ':ToggleTerm direction=horizontal<CR>', { desc = 'Open horizontal termianl' }),

  vim.keymap.set('n', '-', ':Oil<CR>', { desc = 'Open parent directory' }),
  -- Git
  -- TODO: search helpers for
  --  * change branch, * pull , * push

  -- -- gitsigns
  --
  -- -- fugitive
  vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>', { desc = 'Git diff file on in vertical split ' }),
  vim.keymap.set('n', '<Leader>gb', ':G blame<CR>', { desc = 'Show Git blame pane (toggle not workign)' }),

  -- using neogit's instead
  -- vim.keymap.set('n', '<Leader>gs', ':Git<CR>'),

  vim.keymap.set('n', '<Leader>gm', ':GMove ', { desc = 'Git move files by prompts destinantion path' }),
  vim.keymap.set('n', '<Leader>gc', ':G commit<CR>', { desc = 'Git commit' }, { desc = 'Git commits' }), -- commits staged only

  -- `:Git mergetool`
  -- `:Git difftool`
  --  hunks @ init lua
  -- vim.keymap.set('n', '<Leader>gtm', ':G difftool<CR>'),
  -- vim.keymap.set('n', '<Leader>gtd', ':G mergetool<CR>'),

  -- -- neogit
  vim.keymap.set('n', '<Leader>gs', ':Neogit kind=auto<CR>', { silent = true, noremap = true }, { desc = 'Opens Neogit' }),

  -- vim.keymap.set('n', '<Leader>f', '<cmd>NvimTreeToggle<CR>'),
  vim.keymap.set('n', '<Leader>f', '<cmd>Neotree toggle <CR>', { desc = 'Toggles Neotree window' }),

  -- Tabs shortcuts
  vim.keymap.set('n', '<Leader>h', '<cmd>tabprevious<CR>', { desc = 'Tab Previou <-' }),
  vim.keymap.set('n', '<Leader>k', '<cmd>tabnew<CR>', { desc = 'Tab New ^' }),
  vim.keymap.set('n', '<Leader>l', '<cmd>tabnext<CR>', { desc = 'Tab Next ->' }),
  vim.keymap.set('n', '<Leader>o', '<cmd>WindowsMaximize<CR>', { desc = 'Tab Next ->' }),

  -- vim.cmd("iabbrev <expr> ,d strftime('%Y-%m-%d')")
}
