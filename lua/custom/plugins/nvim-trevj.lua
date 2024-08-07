return  { -- Opposition of join-line (J)
  'AckslD/nvim-trevj.lua',
  dependencies= {
    'nvim-treesitter/nvim-treesitter'
  },
  config = function()
    require('trevj').setup {}
    vim.keymap.set('n', '<leader>dj', function()
      return require('trevj').format_at_cursor()
    end, { silent = true, desc = 'Split line (opposite of J)' })
  end,
}
