local dirname = string.sub(debug.getinfo(1).source, 2, string.len("/quickfix.lua") * -1)

return {
  {
    "kevinhwang91/nvim-bqf",
    config = function()
      require("bqf").setup({
        preview = {
          auto_preview = false,
        },
      })
    end,
    dependencies = {
      {
        "junegunn/fzf",
        build = function()
          vim.fn['fzf#install']()
        end,
      },
      "junegunn/fzf.vim",
    },
  },
  {
    dir = dirname .. "/slop_pqf",
    config = function()
      require("slop_pqf").setup()
    end,
  },
}
