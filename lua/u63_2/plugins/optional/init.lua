local u_options = require("u63_2.options")

return {
  { import = 'u63_2/plugins/optional/cpp',        enabled = u_options.cpp.enabled },
  { import = 'u63_2/plugins/optional/tex',        enabled = u_options.tex.enabled },
  { import = 'u63_2/plugins/optional/langmapper', enabled = u_options.langmapper.enabled },
}
