
# TODO's index
## Fix
### leading spaces
### Correct indentation

## Design scripting to clone packer to the ~/.local
https://github.com/wbthomason/packer.nvim
~/.local/share/nvim/site/pack/packer/start/packer.nvim

## Figure out how to make themes work with current color schemes 07:19
https://www.youtube.com/watch?v=w7i4amO_zaE
### Test if `CSApprox` fixes colors on yakuake https://www.vim.org/scripts/script.php?script_id=2390

### Check theme theme folke/tokyonight.nvim after figuring out colorschemes
@ lua/ccolorado/packer.lua-25
@ lua/ccolorado/packer.lua-27

## Find good alternatives to harpoon shurtcuts
@ after/plugin/harpoon.lua

## Check why help is giving out an error
after/plugin/treesitter.lua-6-  -- ensure_installed = { "help", "javascript", "typescript", "c", "rust", "lua", "vim", "vimdoc", "query" },
after/plugin/treesitter.lua-7-  ensure_installed = { "javascript", "typescript", "c", "rust", "lua", "vim", "vimdoc", "query" },
after/plugin/treesitter.lua-8-

## Find the correct way to escape quotes for custom surround schemes
@ after/plugin/vim-surround.lua

## Check current collision with workflow and evaluate utility
@ lua/ccolorado/remap.lua:20
@ lua/ccolorado/remap.lua:26

## Tmux session switch ??? really interesting (requires some tmux tinkering)
@ lua/ccolorado/remap.lua-29

## LSP
### Continue with https://lsp-zero.netlify.app/v3.x/getting-started.html#installing
### Continue with https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
