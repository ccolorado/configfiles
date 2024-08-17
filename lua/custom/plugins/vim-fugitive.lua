-- lazy.nvim

return {
  {
    --disabling to test neogit
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb', -- Browse Github
      'shumphrey/fugitive-gitlab.vim', -- Browse Gitlab
      'tommcdo/vim-fubitive', -- Browse Bitbucket
    },
    config = true,
  },
}
