call plug#begin()

"
" General plugins
" 
Plug 'jiangmiao/auto-pairs'     " autocomplete brackets
Plug 'tpope/vim-surround'       " surround text objects
Plug 'tpope/vim-commentary'     " comments
Plug 'SirVer/ultisnips'         " snippets
Plug 'reconquest/vim-pythonx'   " for smarter snippets
Plug 'lyokha/vim-xkbswitch'     " Language switching (xkg-switch)
Plug 'valloric/youcompleteme'   " autocompletion

" Small misc plugins
Plug 'nelstrom/vim-visual-star-search'
Plug 'lambdalisue/suda.vim'     " sudo write fix
Plug 'joshdick/onedark.vim'     " color theme

" LSP (Language Server Protocol) support
Plug 'neovim/nvim-lspconfig'    
Plug 'williamboman/nvim-lsp-installer'




" TeX "
Plug 'lervag/vimtex'            




" Markdown "
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}




" C/C++ (projects)

" Convienient plugin for CMake projects
Plug 'Shatur/neovim-cmake'
" Dependencies for above
Plug 'nvim-lua/plenary.nvim'    " internal helpers
Plug 'mfussenegger/nvim-dap'    " debugging

" clang-format support
Plug 'rhysd/vim-clang-format'   " clang-format support
Plug 'kana/vim-operator-user'   " dependency for above

" Switching between source and header files
Plug 'derekwyatt/vim-fswitch'



" Rust
Plug 'rust-lang/rust.vim'

call plug#end()
