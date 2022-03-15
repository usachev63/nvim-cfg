call plug#begin()

Plug 'jiangmiao/auto-pairs'     " autocomplete brackets
Plug 'tpope/vim-surround'       " surround text objects

Plug 'neovim/nvim-lspconfig'    " LSP (Language Server Protocol)

Plug 'lervag/vimtex'            " plugin for using tex

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

call plug#end()
