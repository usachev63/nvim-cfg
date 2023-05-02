--[[
-- Entry point of my neovim configuration.
--]]
require 'shar.plugins'
vim.cmd 'source ~/.config/nvim/settings.vim' -- general settings
vim.cmd 'source ~/.config/nvim/maps.vim'     -- general maps

require 'shar.acm_cpp'
vim.cmd 'source ~/.config/nvim/markdown.vim'
vim.cmd 'source ~/.config/nvim/terminal.vim'

-- Change directory scripts
vim.cmd 'source ~/.config/nvim/chdir.vim'

-- Configuration of nvim-autopairs plugin
require 'shar.nvim-autopairs-cfg'

-- Configuration of coq_nvim autocompletion engine
require 'shar.coq-cfg'

-- Configuration of LSP, linters, formatters, etc.
require 'shar.lsp-cfg'

-- telescope.nvim
require 'shar.telescope-cfg'

-- leap.nvim
require 'shar.leap-cfg'

-- lualine
require 'shar.lualine-cfg'

-- local .vimrc
require 'shar.nvim-config-local-cfg'

require 'shar.tabby-cfg'

-- Load optional modules
require 'shar.modules.load'
