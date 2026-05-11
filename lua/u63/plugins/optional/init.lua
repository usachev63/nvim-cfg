local u_options = require("u63.options")

return {
  { import = 'u63/plugins/optional/cpp',        enabled = u_options.cpp.enabled },
  { import = 'u63/plugins/optional/tex',        enabled = u_options.tex.enabled },
  { import = 'u63/plugins/optional/langmapper', enabled = u_options.langmapper.enabled },
  { import = 'u63/plugins/optional/dap',        enabled = u_options.dap.enabled },
}
