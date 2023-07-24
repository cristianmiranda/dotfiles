return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
