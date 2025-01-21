return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  dependencies = { 'Exafunction/codeium.nvim' },
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    -- require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    statusline.setup()

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we replace the section for
    -- cursor information with codeium status instead (it appears on the furthest right of the statusline).
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      local value = ''
      local codeium = require('codeium.virtual_text').status_string()
      value = value .. codeium

      -- check if this is an nvim-remote instance
      if vim.g.remote_neovim_host then
        local remote_name = (" | Remote: %s"):format(vim.uv.os_gethostname()) or ""
        value = value .. remote_name
      end

      return value
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
