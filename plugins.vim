call plug#begin()

Plug 'jiangmiao/auto-pairs'     " autocomplete brackets
Plug 'tpope/vim-surround'       " surround text objects
Plug 'lambdalisue/suda.vim'     " sudo write fix
Plug 'joshdick/onedark.vim'     " color theme


" LSP (Language Server Protocol)
Plug 'neovim/nvim-lspconfig'    
Plug 'williamboman/nvim-lsp-installer'

" Plugin for TeX
Plug 'lervag/vimtex'            

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" Convienient plugin for CMake projects
Plug 'Shatur/neovim-cmake'
" Dependencies for above
Plug 'nvim-lua/plenary.nvim'    " internal helpers
Plug 'mfussenegger/nvim-dap'    " debugging

call plug#end()
