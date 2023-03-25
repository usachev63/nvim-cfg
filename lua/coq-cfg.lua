-- Settings for coq_nvim autocompletion engine

vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    recommended = false,
    pre_select = false,
    jump_to_mark = "<nop>",
  },
  display = {
    ['pum.source_context'] = { "", "" },
    ['ghost_text.enabled'] = false,
    preview = {
      enabled = false,
    },
  },
  clients = {
    ['snippets.enabled'] = false,
    ['lsp.resolve_timeout'] = 0.5,
  },
  ['limits.completion_auto_timeout'] = 0.5,
}
