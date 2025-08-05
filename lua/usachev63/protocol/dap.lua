local M = {}

function M.pack()
  local packer = require 'packer'
  packer.use 'mfussenegger/nvim-dap'
end

function M.init()
  local dap = require 'dap'
  dap.configurations.java = {
    {
      type = 'java',
      request = 'attach',
      name = 'java-attach-remote',
      hostName = '127.0.0.1',
      port = 5005,
    },
  }
  vim.keymap.set('n', ';db', dap.toggle_breakpoint)
  vim.keymap.set('n', ';dc', dap.continue)
  vim.keymap.set('n', ';dr', dap.repl.toggle)
  vim.keymap.set('n', ';dn', dap.step_over)
  vim.keymap.set('n', ';ds', dap.step_into)
  vim.keymap.set('n', ';dS', dap.step_out)
end

return M
