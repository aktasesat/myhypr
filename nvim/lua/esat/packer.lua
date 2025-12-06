

-- first download : packer.nvim on web
-- This file can be loaded by calling `lua require('plugins')` from your init.vimpacker

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- COLOR SCHEMES
	use({ 'sainnhe/gruvbox-material', as = 'gruvbox-material'})	
	-- COLOR SCHEMES END
	use { 'nvim-tree/nvim-tree.lua',
	requires = {
		'nvim-tree/nvim-web-devicons', -- optional
	},
	}
 use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- LSP (Dil Sunucusu)
  use 'neovim/nvim-lspconfig'

  -- Otomatik tamamlama
  use 'hrsh7th/nvim-cmp' -- tamamlama motoru
  use 'hrsh7th/cmp-nvim-lsp' -- LSP kaynaklı tamamlama
 end)

