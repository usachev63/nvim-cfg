--[[
-- Entry point of my neovim configuration.
--]]
require('plugins')
vim.cmd 'source ~/.config/nvim/settings.vim' -- general settings
vim.cmd 'source ~/.config/nvim/maps.vim'     -- general maps

require('acm_cpp')
vim.cmd 'source ~/.config/nvim/markdown.vim'
vim.cmd 'source ~/.config/nvim/terminal.vim'

-- Change directory scripts
vim.cmd 'source ~/.config/nvim/chdir.vim'

-- Configuration of nvim-autopairs plugin
require('nvim-autopairs-cfg')

-- Configuration of coq_nvim autocompletion engine
require('coq-cfg')

-- Configuration of LSP, linters, formatters, etc.
require('lsp-cfg')

-- telescope.nvim
require('telescope-cfg')

-- leap.nvim
require('leap-cfg')

-- lualine
require('lualine-cfg')

-- local .vimrc
require('nvim-config-local-cfg')

require('tabby-cfg')

-- Load optional modules
require('modules/load')
