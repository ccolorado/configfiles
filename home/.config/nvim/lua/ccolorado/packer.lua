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

	-- use ({
	-- 	'rose-pine/neovim',
	-- 	as = 'rose-pine',
	-- 	-- config = function()
	-- 	-- 	vim.cmd('colorscheme rose-pine')
	-- 	-- end
	-- })


    use('folke/tokyonight.nvim')

	-- TODO: Try CSApprox to fix colors on yakuake https://www.vim.org/scripts/script.php?script_id=2390

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('nvim-treesitter/playground')
	use('theprimeagen/harpoon')
	use('mbbill/undotree')

	use('scrooloose/nerdtree')
	use('tpope/vim-fugitive')
  	use('tpope/vim-surround')
  	use('tpope/vim-commentary')
    use('airblade/vim-gitgutter')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            -- {'williamboman/mason.nvim'},
            -- {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
			{'saadparwaiz1/cmp_luasnip'},

			-- {'hrsh7th/cmp-buffer'},
			-- {'hrsh7th/cmp-nvim-lua'},
			-- {'hrsh7th/cmp-path'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
			-- {'rafamadriz/friendly-snippets'},
        }
    }

    -- TODO: continue with https://lsp-zero.netlify.app/v3.x/getting-started.html#installing
    -- TODO: continue with https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    -- TODO: fix identation

end)
