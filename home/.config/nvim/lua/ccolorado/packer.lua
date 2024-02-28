-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
     	use 'wbthomason/packer.nvim'

	use {
		  'nvim-telescope/telescope.nvim', tag = '0.1.5',
		  -- or                            , branch = '0.1.x',
		  requires = { {'nvim-lua/plenary.nvim'} }
        }

	use ({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	})

	-- TODO: Try CSApprox to fix colors on yakuake https://www.vim.org/scripts/script.php?script_id=2390

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('nvim-treesitter/playground')
	use('theprimeagen/harpoon')
	use('mbbill/undotree')

	-- TODO: migrate configuration from ~/.vimrc

	use('tpope/vim-fugitive')
  	use('tpope/vim-surround')
  	use('tpope/vim-commentary')
    use('airblade/vim-gitgutter')

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Suppport
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}


end)
