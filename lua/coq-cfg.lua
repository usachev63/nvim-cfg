-- Settings for coq_nvim autocompletion engine

vim.g.coq_settings = {
    auto_start = 'shut-up',
    keymap = {
      pre_select = false,
    },
    display = {
        ['pum.source_context'] = {"", ""},
        ['ghost_text.enabled'] = false,
        preview = {
            enabled = false,
        },
    },
    ['clients.snippets.enabled'] = false,
}
