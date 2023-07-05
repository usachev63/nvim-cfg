return {
  setup = function()
    local packer = require 'packer'
    packer.use { 'rust-lang/rust.vim', ft = 'rust' }
  end
}
