return {
  "akinsho/bufferline.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup{}
  end,
}

