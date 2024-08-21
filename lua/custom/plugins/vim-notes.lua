return {
  {
    'xolox/vim-notes',
    dependencies = { 'xolox/vim-misc' },
    config = function()
      vim.g.notes_directories = { '~/Notes/src' }
      vim.g.notes_conceal_code = 0
      vim.g.notes_smart_quotes = 0
    end,
  },
}
