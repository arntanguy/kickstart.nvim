-- lazydocker.nvim
-- You must first install Lazydocker on your system, see https://github.com/jesseduffield/lazydocker for instructions
return {
  "mgierada/lazydocker.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    require("lazydocker").setup({})
  end,
  event = "BufRead",
  keys = {
    {
      "<leader>ld",
      function()
        require("lazydocker").open()
      end,
      desc = "Open Lazydocker floating window",
    },
  },
}
