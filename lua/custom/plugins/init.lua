-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  { 'tpope/vim-obsession' },
  { 'junegunn/vim-easy-align' },
  {
    'xolox/vim-notes',
    dependencies = { 'xolox/vim-misc' },
    config = function()
      vim.g.notes_directories = { '~/Notes/src' }
      vim.g.notes_conceal_code = 0
      vim.g.notes_smart_quotes = 0
    end,
  },
  { 'tommcdo/vim-exchange' },
  { 'AndrewRadev/linediff.vim' },
  { 'sindrets/diffview.nvim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
        },
        dim_inactive = {
          enabled = false,
          shade = 'dark',
          percentage = 0.15,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
