return { -- Codeium AI code completion
  -- NOTE: codium.nvim exists and has cmp support, but when I tried it only provided single-line suggestions
  -- which is useless. Probably a bug, might want to recheck later
  'Exafunction/codeium.vim',
  lazy = true,
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<C-g>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true, desc = 'Accept Codeium Completion' })
    vim.keymap.set('i', '<M-]>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true, desc = 'Next Codeium Completion' })
    vim.keymap.set('i', '<M-[>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true, desc = 'Previous Codeium Completion' })
    vim.keymap.set('i', '<c-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true, desc = 'Clear Codeium Completion' })
  end,
}
