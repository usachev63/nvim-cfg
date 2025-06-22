---nvim-cmp: autocompletion engine

local M = {}

local vim = vim
local options = require 'usachev63.options'

---Compile a list of source for nvim-cmp from usachev63-nvim-cfg options.
---
---@return table[] # The list of sources for nvim-cmp.
local function get_sources()
  local sources = {}
  if type(options.protocol.lsp) == 'table' then
    table.insert(sources, {
      name = 'nvim_lsp',
    })
  end
  table.insert(sources, {
    name = 'buffer',
    option = {
      keyword_pattern = [[\k\+]],
      get_bufnrs = function() -- visible buffers
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local byte_size =
            vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
          if byte_size <= 1024 * 1024 then -- 1 Megabyte max
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
        end
        return vim.tbl_keys(bufs)
      end,
    },
  })
  table.insert(sources, {
    name = 'path',
  })
  return sources
end

function M.pack()
  local packer = require 'packer'
  packer.use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
    },
  }
  packer.use 'hrsh7th/cmp-path'
end

---Set up integration with nvim-cmp.
function M.init()
  local cmp = require 'cmp'
  cmp.setup {
    mapping = cmp.mapping.preset.insert {},
    sources = cmp.config.sources(get_sources()),
  }
end

return M
