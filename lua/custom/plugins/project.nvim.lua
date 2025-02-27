return {
  "ahmedkhalf/project.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "folke/which-key.nvim"
  },
  config = function()
    require("project_nvim").setup(
      {
          -- Methods of detecting the root directory. **"lsp"** uses the native neovim
          -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
          -- order matters: if one is not detected, the other is used as fallback. You
          -- can also delete or rearangne the detection methods.
          detection_methods = { "pattern" },

          -- All the patterns used to detect root dir, when **"pattern"** is in
          -- detection_methods
          patterns = { ".git", ".devcontainer", "package.json" },

          exclude_dirs = {"*/cmake"},
      }
    )
    require('telescope').load_extension('projects')

    local wk = require("which-key")
    wk.add(
      {
        { "<leader>sp", ":Telescope projects<CR>", desc = "[S]elect [P]roject" },
      }
    )
  end,
}
