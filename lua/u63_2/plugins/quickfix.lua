return {
  'kevinhwang91/nvim-bqf',
  config = function()
    local bqf = require 'bqf'
    bqf.setup {
      preview = {
        auto_preview = false,
      },
    }
  end,
}
