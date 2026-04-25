local dirname = string.sub(debug.getinfo(1).source, 2, string.len('/quickfix.lua') * -1)

return {
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      local bqf = require 'bqf'
      bqf.setup {
        preview = {
          auto_preview = false,
        },
      }
    end,
  },
  {
    dir = dirname .. '/persistent-qf',
    config = function()
      require("persistent-qf").setup()
    end,
  },
}
