---@class Options
local M = {}

---@class Options
---
---Options for shar-nvim-cfg.
---
---@field editing Options_Editing
---@field key Options_Key
---@field localvimrc boolean Support project-local Neovim configuration files.
---@field navigation Options_Navigation
---@field protocol Options_Protocol
---@field toolkit Options_Toolkit

---@class Options_Editing
---
---Options which affect editing text ('editing' module).
---
---@field cmp {}? Use nvim-cmp autocompletion engine.
---@field enable_autopairs boolean Use nvim-autopairs bracket
---autocompletion plugin.
---@field sakls Options_Sakls Options for sakls.nvim plugin.

---@class Options_Sakls
---
---Options for sakls.nvim plugin.
---
---@field enabled boolean Enable sakls.nvim plugin.
---@field sakls_nvim_path string Path to sakls.nvim repository for packer.
---@field options table Options table for sakls.nvim init function.

---@class Options_Key
---
---Options which affect keymaps or keyboard layouts (key module).
---
---@field enable_langmapper boolean Use langmapper.nvim plugin to
---automatically translate mappings to russian keyboard layout.
---@field layout_lib LayoutLib?

---@alias LayoutLib XkbSwitchLayoutLib
---
---Specify backend library which will implement API for
---getting/setting system keyboard layout.
---
---At the moment, only xkb-switch is supported, but support for more
---backend libraries can be easily added in the future.

---@class XkbSwitchLayoutLib
---
---Specify xkb-switch backend library for implementing layout API.
---
---@field [1] "xkb-switch" Declares that xkb-switch is used as a layout library.
---@field xkb_switch_lib_path string Path to xkb-switch shared library
---(usually has the name 'libxkbswitch.so').

---@class Options_Navigation
---
---Options which control navigation between files (or other entities).
---
---@field nnn { enabled: boolean } Options for nnn.nvim plugin.
---@field nvim_tree { enabled: boolean } Options for nvim-tree plugin;
---currently we can only enable or disable it.

---@class Options_NvimTree
---
---Options for nvim-tree plugin.
---
---@field enabled boolean
---@field netrw_style boolean

---@class Options_Protocol
---
---Options for configuring various protocols: LSPs, formatters, linters,
---DAPs, treesitter, etc.
---
---@field formatter {}? Enable support of formatters.
---@field lsp {}? Enable support of LSP.
---@field treesitter {}? Enable treesitter support.
---@field linter {}? Enable linters support.

---@class Options_Toolkit
---
---Options for toolkit-specific configurations.
---
---@field acmcpp AcmCppOptions ACM-style programming in C++.
---@field coq { enabled: boolean } Coq proof assistant.
---@field dafny { enabled: boolean } Dafny programming & verification language.
---@field git { enabled: boolean } Git version control system.
---@field java { enabled: boolean } Java support
---@field rust { enabled: boolean } Rust programming language.
---@field tex TexOptions
---@field markdown { enabled: boolean } Markdown preview editing support.
---@field distant { enabled: boolean } distant: remote FS & process operations.
---@field opencl { enabled: boolean } OpenCL support.
---@field python PythonOptions Python development.
---@field i3 { enabled: boolean } i3 config support.
---@field csv { enabled: boolean } CSV support.
---@field scala { enabled: boolean } Scala support.

---@class AcmCppOptions
---
---Support of ACM-style programming in C++.
---
---@field enabled boolean Enable support of ACM C++.
---@field template_path string? Path to the ACM C++ template file.

---@class TexOptions
---
---TeX support.
---
---@field enabled boolean Enable TeX support.
---@field template_file string? Path to template TeX file.
---@field inkscape_figures string? Path to inkscape-figures tool:
---Inkscape figure manager.
---@field sakls TexSaklsOptions

---@class PythonOptions
---
---Python development.
---
---@field venv_selector { enabled: boolean }
---Plugin for selecting Python virtual environments.

---@class TexSaklsOptions
---
---Using sakls.nvim for TeX.
---
---@field enabled boolean Enable using sakls.nvim for TeX.
---@field schema? string|table Define SAKLS schema to use.

---Default shar-nvim-cfg options.
---
---@type Options
local default_options = {
  editing = {
    cmp = nil,
    enable_autopairs = true,
    sakls = {
      enabled = false,
      sakls_nvim_path = 'sharkov63/sakls.nvim',
      options = {},
    },
  },
  key = {
    enable_langmapper = false,
    layout_lib = nil,
  },
  localvimrc = false,
  navigation = {
    nvim_tree = {
      enabled = false,
    },
    nnn = {
      enabled = false,
    }
  },
  protocol = {
    formatter = nil,
    lsp = nil,
    treesitter = nil,
    linter = nil,
  },
  toolkit = {
    acmcpp = {
      enabled = false,
      template_path = nil,
    },
    coq = {
      enabled = false,
    },
    dafny = {
      enabled = false,
    },
    git = {
      enabled = true,
    },
    java = {
      enabled = false,
    },
    rust = {
      enabled = false,
    },
    tex = {
      enabled = false,
      template_file = nil,
      inkscape_figures = nil,
      sakls = {
        enabled = false,
        schema = nil,
      },
    },
    markdown = {
      enabled = false,
    },
    distant = {
      enabled = false,
    },
    opencl = {
      enabled = false,
    },
    python = {
      venv_selector = {
        enabled = false,
      },
    },
    i3 = {
      enabled = false,
    },
    csv = {
      enabled = true,
    },
    scala = {
      enabled = false,
    },
  },
}

---Handle shar-nvim-cfg options provided by the user.
---
---@param opts any Raw, user-provided options for shar-nvim-cfg.
---@return Options M Processed and ready-to-use options table.
---Throws an error if provided options are ill-formed.
function M.init(opts)
  opts = opts or {}
  if type(opts) ~= 'table' then
    error('[shar.options] init called with non-table second argument!', 3)
  end
  opts = vim.tbl_deep_extend('force', default_options, opts)
  setmetatable(M, { __index = opts })
  return M
end

return M
