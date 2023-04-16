call plug#begin()

"
" General plugins
" 
Plug 'windwp/nvim-autopairs'     " autocomplete brackets
Plug 'tpope/vim-surround'        " surround text objects
Plug 'tpope/vim-commentary'      " comments
Plug 'SirVer/ultisnips'          " snippets
Plug 'reconquest/vim-pythonx'    " for smarter snippets
Plug 'lyokha/vim-xkbswitch'      " Language switching (xkg-switch)
Plug 'tpope/vim-fugitive'        " Git
Plug 'tpope/vim-repeat'
Plug 'nelstrom/vim-visual-star-search'
Plug 'lambdalisue/suda.vim'      " sudo write fix
Plug 'joshdick/onedark.vim'      " color theme
Plug 'morhetz/gruvbox'           " color theme
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'klen/nvim-config-local'    " local .vimrc

" LSP, linters, formatters support
Plug 'neovim/nvim-lspconfig'    
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" coq_nvim: autocompletion
Plug 'skylerberg/coq_nvim', {'branch': 'preview-enable-setting'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim', { 'branch': 'master' }
Plug 'nvim-lua/plenary.nvim'     " dependency for above

" Leap movement
Plug 'ggandor/leap.nvim'

"
" TeX
"
Plug 'lervag/vimtex'




"
" Markdown
" 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}




" Rust
Plug 'rust-lang/rust.vim'




" Coq
Plug 'whonore/Coqtail'

call plug#end()
