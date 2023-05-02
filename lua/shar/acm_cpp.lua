local loadTemplate = function()
  local templateFile = assert(io.open("/home/danila/ACM/lib/Template.cpp", "r"))
  local lines = {}
  for line in templateFile:lines() do
    table.insert(lines, line)
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

local mapBuildHotkeys = function()
  -- Build & Run mapping
  vim.api.nvim_buf_set_keymap(0, "n", "<F10>",
    ":write | terminal acm % && ./%:r < in<CR>", {
      noremap = true
    })
  -- Only Run mapping
  vim.api.nvim_buf_set_keymap(0, "n", "<F9>",
    ":write | terminal ./%:r < in<CR>", {
      noremap = true
    })
end

local acmCppAuGroup = vim.api.nvim_create_augroup("AcmCpp", {})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.acm",
  callback = loadTemplate,
  group = acmCppAuGroup
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.acm",
  callback = mapBuildHotkeys,
  group = acmCppAuGroup,
})
