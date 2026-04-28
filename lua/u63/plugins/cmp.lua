---nvim-cmp: autocompletion engine

---Compile a list of sources for nvim-cmp.
---
---@return table[] # The list of sources for nvim-cmp.
local function get_sources()
  local sources = {}
  table.insert(sources, {
    name = 'nvim_lsp',
  })
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

return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources(get_sources()),
      }
    end,
  },
}
