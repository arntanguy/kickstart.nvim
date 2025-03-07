return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "folke/which-key.nvim"
  },
  config = function()
    require("telescope").load_extension "file_browser"
    -- open file_browser with the path of the current buffer
    local wk = require("which-key")
    wk.add({"<space>sb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "[S]earch [B]rowser (current file)", icon='📂' })
  end
}
