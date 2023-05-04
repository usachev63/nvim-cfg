--[[
-- coq_nvim: fast autocompletion engine.
--]]
local packer = require 'packer'
packer.use {
  'ms-jpq/coq_nvim',
  branch = 'coq',
  requires = {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts',
  },
}

vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    recommended = false,
    pre_select = false,
    jump_to_mark = "<nop>",
  },
  display = {
    pum = {
      source_context = { "", "" },
    },
    ghost_text = {
      enabled = false,
    },
    preview = {
      enabled = false,
    },
  },
  clients = {
    snippets = {
      enabled = false,
    }
  },
  limits = {
    completion_auto_timeout = 0.5,
  },
}
