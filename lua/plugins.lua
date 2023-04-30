--[[

Initialize packer.nvim plugin manager.
Declare common plugins.

Plugins can also be declared in any other place with
  require('packer').use 'username/reponame',
but it must be done after this module is loaded.

]]
local packer = require('packer')
packer.init()

packer.use 'wbthomason/packer.nvim' -- plugin manager itself

packer.use 'windwp/nvim-autopairs'  -- autocomplete brackets
packer.use 'tpope/vim-surround'     -- surround text objects
packer.use 'tpope/vim-commentary'   -- comments
packer.use 'SirVer/ultisnips'       -- snippets
packer.use 'reconquest/vim-pythonx' -- for smarter snippets
packer.use 'lyokha/vim-xkbswitch'   -- Language switching (xkg-switch)
packer.use 'tpope/vim-fugitive'     -- Git
packer.use 'tpope/vim-repeat'
packer.use 'nelstrom/vim-visual-star-search'
packer.use 'lambdalisue/suda.vim' -- sudo write fix
packer.use 'joshdick/onedark.vim' -- color theme
packer.use 'morhetz/gruvbox'      -- color theme
packer.use 'nvim-lualine/lualine.nvim'
packer.use 'nvim-tree/nvim-web-devicons'
packer.use 'klen/nvim-config-local' -- local .vimrc
packer.use 'nanozuki/tabby.nvim'

-- LSP, linters, formatters support
packer.use 'neovim/nvim-lspconfig'
packer.use 'williamboman/mason.nvim'
packer.use 'williamboman/mason-lspconfig.nvim'
packer.use 'mhartington/formatter.nvim'
packer.use {
  'nvim-treesitter/nvim-treesitter',
  run = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()
  end,
}

-- coq_nvim: autocompletion
packer.use {
  'sharkov63/coq_nvim',
  branch = 'coq',
  requires = {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts',
  },
}

-- Fuzzy finder
packer.use {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
  requires = {
    'nvim-lua/plenary.nvim',
  },
}

-- Leap movement
packer.use 'ggandor/leap.nvim'

--
-- TeX
--




-- Rust
packer.use 'rust-lang/rust.vim'




-- Coq
packer.use 'whonore/Coqtail'
