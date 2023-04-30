" Entry point of my neovim configuration.

" General configuration
lua require('plugins')
source ~/.config/nvim/settings.vim    " general settings
source ~/.config/nvim/maps.vim        " general maps

" Filetype-specific configuration
lua require('acm_cpp')
source ~/.config/nvim/latex.vim       " utilities for using latex
source ~/.config/nvim/markdown.vim    " markdown settings
source ~/.config/nvim/terminal.vim

" Change directory scripts
source ~/.config/nvim/chdir.vim

" Configuration of nvim-autopairs plugin
lua require('nvim-autopairs-cfg')

" Configuration of coq_nvim autocompletion engine
lua require('coq-cfg')

" Configuration of LSP, linters, formatters, etc.
lua require('lsp-cfg')

" Language auto-switching for latex
lua require('latex/language-switch')
lua require('latex/vimtex-plug')

" telescope.nvim
lua require('telescope-cfg')

" leap.nvim
lua require('leap-cfg')

" lualine
lua require('lualine-cfg')

" local .vimrc
lua require('nvim-config-local-cfg')

lua require('tabby-cfg')
