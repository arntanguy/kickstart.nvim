-- lsp configuration using vim.lsp
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/#improved-hover-documentation for details
--
-- configuration for each lsp is in ./lsp/<lsp name>.lua
--
-- Default keymaps:
-- 
--    grn in Normal mode maps to vim.lsp.buf.rename()
--    grr in Normal mode maps to vim.lsp.buf.references()
--    gri in Normal mode maps to vim.lsp.buf.implementation()
--    gO in Normal mode maps to vim.lsp.buf.document_symbol() (this is analogous to the gO mappings in help buffers and :Man page buffers to show a “table of contents”)
--    gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
--    CTRL-S in Insert and Select mode maps to vim.lsp.buf.signature_help()
--    [d and ]d move between diagnostics in the current buffer ([D jumps to the first diagnostic, ]D jumps to the last)
--
--We’ve also included versions of some of the mappings from Tim Pope’s vim-unimpaired:
--
--    [q, ]q, [Q, ]Q, [CTRL-Q, ]CTRL-Q navigate through the quickfix list
--    [l, ]l, [L, ]L, [CTRL-L, ]CTRL-L navigate through the location list
--    [t, ]t, [T, ]T, [CTRL-T, ]CTRL-T navigate through the tag matchlist
--    [a, ]a, [A, ]A navigate through the argument list
--    [b, ]b, [B, ]B navigate through the buffer list
--    [<Space>, ]<Space> add an empty line above and below the cursor
--
vim.lsp.enable('clangd')
-- vim.lsp.enable('lua-language-server')

-- Add additional keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP relted items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc =  desc })
    end

    require('which-key').add {
      { '<leader>cs', group = '[C]ode [S]earch', icon='🔎'},
      { '<leader>cs_', hidden = true },
      { '<leader>g', group = '[G]oto', icon='👀'},
      { '<leader>g_', hidden = true },
    }

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-T>.
    map('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- Find references for the word under your cursor.
    map('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('<leader>gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('<leader>gD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

    -- Fuzzy find all the symbols in your current workspace
    --  Similar to document symbols, except searches over your whole project.
    map('<leader>css', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[C]ode [S]earch [S]ymbols')

    -- Rename the variable under your cursor
    --  Most Language Servers support renaming across files, etc.
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap
    map('<leader>cK', vim.lsp.buf.hover, 'Hover Documentation')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Setup custom bindings for clangd
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client.name == 'clangd' then
      -- map('gh', ':ClangdSwitchSourceHeader<CR>', '[G]o to [H]eader or Source (clang)')
    end

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
    vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
    vim.keymap.set('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
