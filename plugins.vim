call plug#begin()

Plug 'jiangmiao/auto-pairs'     " autocomplete brackets
Plug 'tpope/vim-surround'       " surround text objects

" LSP (Language Server Protocol)
Plug 'neovim/nvim-lspconfig'    
Plug 'williamboman/nvim-lsp-installer'

Plug 'lervag/vimtex'            " plugin for using tex

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

call plug#end()
