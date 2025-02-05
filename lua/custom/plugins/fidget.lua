return {
  "j-hui/fidget.nvim",
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require("fidget").setup({
      notification = {
        override_vim_notify = true
      }
    })
    require('telescope').load_extension('fidget')
  end
}
