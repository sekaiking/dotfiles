-- checks if the packer.nvim directory exists. If not, it clones the repository
local packerPath = vim.fn.stdpath("data") .. "/packer.nvim"
if not vim.loop.fs_stat(packerPath) then
  vim.fn.system({
    "git",
    "clone",
    "--depth=1",
    "https://github.com/wbthomason/packer.nvim.git",
    packerPath,
  })
end
vim.opt.rtp:prepend(packerPath)


vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Auto bracket close on enter
  use 'rstacruz/vim-closer'

  -- Comment
  use(
    'numToStr/Comment.nvim'
  )

  -- Syntax Highlighting
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('HiPhish/rainbow-delimiters.nvim')
  use('brenoprata10/nvim-highlight-colors')
  use('Glench/Vim-Jinja2-Syntax')

  -- LSP / CMP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp'
  }
  use {
    'L3MON4D3/LuaSnip',
    tag = "v2.*",
    run = "make install_jsregexp"
  }
  use {
    'saadparwaiz1/cmp_luasnip',
  }
  use("zbirenbaum/copilot.lua")
  use("zbirenbaum/copilot-cmp")

  -- Lua Line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- theme
  use('craftzdog/solarized-osaka.nvim')

  -- start
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
  }

  -- File Explorer
  use {
    'https://github.com/nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Undo tree
  use('mbbill/undotree')

  -- Smooth scroll C+u C+D
  use 'karb94/neoscroll.nvim'

  -- Git stuff
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'

  -- Improve split windows
  use 'nvim-focus/focus.nvim'

  -- Prettier
  use 'stevearc/conform.nvim'

  -- motions
  use 'folke/flash.nvim'

  -- Lsp helper
  use 'ray-x/lsp_signature.nvim'
  use 'folke/trouble.nvim'
  use 'RaafatTurki/corn.nvim'

  -- icons
  use 'nvim-tree/nvim-web-devicons'
end)
