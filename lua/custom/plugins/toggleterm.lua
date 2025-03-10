return {
  'akinsho/toggleterm.nvim',
  dependencies = {
    'ryanmsndyder/toggleterm-manager.nvim', -- for telescope
    'folke/which-key.nvim'
  },
  config = function()
    require("toggleterm").setup({
    })
      _G.set_terminal_keymaps = function()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { desc = '[T]erm [T]oggle' })
      vim.keymap.set('n', '<leader>ta', ':ToggleTermToggleAll<CR>', { desc = '[T]erm Toggle [A]ll' })
      vim.keymap.set('n', '<leader>ts', ':TermSelect<CR>', { desc = '[T]erm [S]elect' })
      vim.keymap.set('n', '<leader>tm', ':Telescope toggleterm_manager<CR>', { desc = '[T]erm [S]elect' })
      vim.keymap.set('n', '<leader>tn', ':ToggleTermSetName<CR>', { desc = '[T]erm [R]ename' })
      vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float name=floatterm<CR>', { desc = '[T]erm [F]loat' })

      require('which-key').add {
        { '<leader>t', group = '[T]erminal', icon = ""},
        { '<leader>t_', hidden = true },
      }
  end
}
