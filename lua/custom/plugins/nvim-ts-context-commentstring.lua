return {
  -- Context aware comment strings.
  -- For instance JSX has two types of comments, // for regular javascript/typescript, and { /* ... */ } for JSX
  -- This treesitter extension allows to set the correct comment string based on code context
  -- Use Comment.nvim to apply the commentstrings easyly (with 'gcc')
  "JoosepAlviste/nvim-ts-context-commentstring",
  lazy = true, -- Only loaded when treesitter loads (since it is specified as a dependency of treesitter)
  config = function()
    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }
  end,
}
