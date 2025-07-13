---Formatters support.

local M = {}

local vim = vim
local keymap = vim.keymap

function M.pack()
  require('packer').use 'mhartington/formatter.nvim'
end

---Set up formatters support.
function M.init()
  -- formatter.nvim
  local formatter = require 'formatter'
  -- TODO split formatters into separate files
  formatter.setup {
    filetype = {
      json = {
        require('formatter.filetypes.json').fixjson,
      },
      lua = {
        require('formatter.filetypes.lua').stylua,
      },
      cmake = {
        require('formatter.filetypes.cmake').cmakeformat,
      },
      python = {
        require('formatter.filetypes.python').autopep8,
      },
      kotlin = {
        function()
          return {
            exe = 'ktfmt',
            args = {
              '--kotlinlang-style',
              '-',
            },
            stdin = true,
          }
        end,
      },
      xml = {
        require('formatter.filetypes.xml').xmllint,
      },
      java = {
        require('formatter.filetypes.java').google_java_format,
      },
    },
  }
  --- Setup format keymap
  local augroup = vim.api.nvim_create_augroup('usachev63.formatter', {})
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'json', 'lua', 'cmake', 'python', 'kotlin' },
    callback = function()
      keymap.set('n', '<Leader>fm', ':Format<CR>', { buffer = true })
    end,
    group = augroup,
  })
end

return M
