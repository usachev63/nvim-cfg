return {
  {
    "SirVer/ultisnips",
    config = function()
      vim.keymap.set({ 'n', 'i' }, '<C-J>', '<Nop>')
      vim.g.UltiSnipsExpandTrigger = '<C-l>'
      vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'
    end,
  }
}
