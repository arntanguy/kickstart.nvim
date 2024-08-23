return  {
  -- XXX: neovim now has in-built support for commenting
  -- consider using it
  -- use "gc" to comment visual regions/lines
  'numToStr/Comment.nvim',
  dependencies = { 'JoosepAlvist/nvim-ts-context-commentstring' },
  config = function() require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end
}

