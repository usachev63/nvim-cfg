return {
  pack = function()
    local packer = require 'packer'
    packer.use { 'whonore/Coqtail', ft = 'coq' }
  end,
  setup = function()
    vim.g.coqtail_noimap = true
  end,
}
