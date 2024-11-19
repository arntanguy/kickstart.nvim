return {
   "amitds1997/remote-nvim.nvim",
   version = "*", -- Pin to GitHub releases
   dependencies = {
       "nvim-lua/plenary.nvim", -- For standard functions
       "MunifTanjim/nui.nvim", -- To build the plugin UI
       "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
   },
  config = true
  -- config = function()
  --   require("remote-nvim").setup(
  --     {
  --       -- Configuration for devpod connections
  --       devpod = {
  --         binary = "devpod", -- Binary to use for devpod
  --       }
  --     }
  --   )
  -- end,
}
