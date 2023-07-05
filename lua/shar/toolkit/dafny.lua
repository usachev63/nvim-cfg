return {
  setup = function()
    local packer = require 'packer'
    packer.use { 'mlr-msft/vim-loves-dafny', ft = 'dafny' }
  end
}

