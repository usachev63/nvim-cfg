return {
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'lambdalisue/suda.vim', -- sudo write fix
  'rcarriga/nvim-notify',
  {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup {
        input = {
          insert_only = false,
          mappings = {
            n = {
              ['<Esc>'] = 'Close',
              ['<C-c>'] = 'Close',
              ['<CR>'] = 'Confirm',
            },
            i = {
              ['<C-c>'] = 'Close',
              ['<CR>'] = 'Confirm',
              ['<Up>'] = 'HistoryPrev',
              ['<Down>'] = 'HistoryNext',
            },
          },
        },
      }
    end,
  },
  'google/vim-searchindex',
  'MTDL9/vim-log-highlighting',
}
