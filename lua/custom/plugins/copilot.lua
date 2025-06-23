-- Set env variable:
-- GITHUB_COPILOT_TOKEN=***
-- To get the token, run :Copilot auth then :Copilot auth info
--
-- Supermaven is better?
-- return {}
return {
  -- Main copilot.lua plugin
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      "folke/which-key.nvim", -- Optional: for keymap documentation
    },
    opts =
    {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          -- Enable for most file types
          ["*"] = true,

          -- Disable for specific file types
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          help = false,

          -- Enable for common development files
          yaml = true,        -- Enable YAML (you wanted this enabled)
          yml = true,
          markdown = true,    -- Enable markdown
          json = true,
          jsonc = true,
          lua = true,
          python = true,
          javascript = true,
          typescript = true,
          go = true,
          rust = true,
          c = true,
          cpp = true,

          -- Disable for these specific cases
          ["."] = false,      -- Disable for files with no extension
          ["dap-repl"] = false,
          ["dapui_watches"] = false,
          ["dapui_stacks"] = false,
          ["dapui_breakpoints"] = false,
          ["dapui_scopes"] = false,
          ["dapui_console"] = false,
          ["TelescopePrompt"] = false,
          ["codecompanion"] = false, -- Disable in CodeCompanion chat
          ["oil"] = false,
          ["neo-tree"] = false,
        },
    }
    -- config = function()
    --   require("copilot").setup({
    --     panel = {
    --       enabled = true,
    --       auto_refresh = false,
    --       keymap = {
    --         jump_prev = "[[",
    --         jump_next = "]]",
    --         accept = "<CR>",
    --         refresh = "gr",
    --         open = "<M-CR>" -- Alt+Enter to open panel
    --       },
    --       layout = {
    --         position = "bottom", -- "bottom" | "top" | "left" | "right"
    --         ratio = 0.4
    --       },
    --     },
    --     suggestion = {
    --       enabled = true,
    --       auto_trigger = true,
    --       hide_during_completion = true, -- Hide suggestions when completion menu is open
    --       debounce = 75, -- Debounce time in ms
    --       keymap = {
    --         accept = "<C-J>",        -- Accept suggestion
    --         accept_word = "<C-Right>", -- Accept next word
    --         accept_line = "<C-L>",   -- Accept next line
    --         next = "<M-]>",          -- Next suggestion
    --         prev = "<M-[>",          -- Previous suggestion
    --         dismiss = "<C-K>",       -- Dismiss suggestion
    --       },
    --     },
    --     copilot_node_command = 'node', -- Node.js version must be > 18.x
    --     server_opts_overrides = {
    --       -- Advanced server options (optional)
    --       trace = "off", -- "off" | "messages" | "verbose"
    --       settings = {
    --         advanced = {
    --           listCount = 10, -- Number of completions for panel
    --           inlineSuggestCount = 3, -- Number of inline suggestions
    --         }
    --       }
    --     },
    --   })
    --
    --   -- Optional: Setup which-key documentation
    --   local wk = require("which-key")
    --   wk.add({
    --     { "<leader>cp", group = "[C]o[p]ilot", icon = "🤖" },
    --     { "<leader>cp_", hidden = true },
    --   })
    --
    --   -- Additional keymaps for Copilot management
    --   vim.keymap.set("n", "<leader>cpe", "<cmd>Copilot enable<cr>", {
    --     desc = "[C]o[p]ilot [E]nable",
    --     silent = true
    --   })
    --
    --   vim.keymap.set("n", "<leader>cpd", "<cmd>Copilot disable<cr>", {
    --     desc = "[C]o[p]ilot [D]isable",
    --     silent = true
    --   })
    --
    --   vim.keymap.set("n", "<leader>cps", "<cmd>Copilot status<cr>", {
    --     desc = "[C]o[p]ilot [S]tatus",
    --     silent = true
    --   })
    --
    --   vim.keymap.set("n", "<leader>cpp", "<cmd>Copilot panel<cr>", {
    --     desc = "[C]o[p]ilot [P]anel",
    --     silent = true
    --   })
    --
    --   vim.keymap.set("n", "<leader>cpr", "<cmd>Copilot restart<cr>", {
    --     desc = "[C]o[p]ilot [R]estart",
    --     silent = true
    --   })
    --
    --   vim.keymap.set("n", "<leader>cpv", "<cmd>Copilot version<cr>", {
    --     desc = "[C]o[p]ilot [V]ersion",
    --     silent = true
    --   })
    --
    --   vim.keymap.set("n", "<leader>cpa", "<cmd>Copilot auth<cr>", {
    --     desc = "[C]o[p]ilot [A]uth",
    --     silent = true
    --   })
    --
    --   -- Buffer-specific toggle
    --   vim.keymap.set("n", "<leader>cpt", function()
    --     local buf = vim.api.nvim_get_current_buf()
    --     local current_state = vim.b[buf].copilot_enabled
    --
    --     if current_state == false then
    --       vim.b[buf].copilot_enabled = true
    --       vim.notify("Copilot enabled for current buffer", vim.log.levels.INFO)
    --     else
    --       vim.b[buf].copilot_enabled = false
    --       vim.notify("Copilot disabled for current buffer", vim.log.levels.INFO)
    --     end
    --   end, {
    --     desc = "[C]o[p]ilot [T]oggle buffer",
    --     silent = true
    --   })
    --
    --   -- Filetype-specific toggle for YAML
    --   vim.keymap.set("n", "<leader>cpy", function()
    --     local ft = vim.bo.filetype
    --     if ft == "yaml" or ft == "yml" then
    --       local current_state = vim.b.copilot_enabled
    --       if current_state == false then
    --         vim.b.copilot_enabled = true
    --         vim.notify("Copilot enabled for YAML", vim.log.levels.INFO)
    --       else
    --         vim.b.copilot_enabled = false
    --         vim.notify("Copilot disabled for YAML", vim.log.levels.INFO)
    --       end
    --     else
    --       vim.notify("Not in a YAML file", vim.log.levels.WARN)
    --     end
    --   end, {
    --     desc = "[C]o[p]ilot toggle [Y]AML",
    --     silent = true
    --   })
    --
    --   -- Create user commands for easier access
    --   vim.api.nvim_create_user_command("CopilotToggleBuffer", function()
    --     local buf = vim.api.nvim_get_current_buf()
    --     local current_state = vim.b[buf].copilot_enabled
    --
    --     if current_state == false then
    --       vim.b[buf].copilot_enabled = true
    --       vim.notify("Copilot enabled for current buffer", vim.log.levels.INFO)
    --     else
    --       vim.b[buf].copilot_enabled = false
    --       vim.notify("Copilot disabled for current buffer", vim.log.levels.INFO)
    --     end
    --   end, { desc = "Toggle Copilot for current buffer" })
    --
    --   vim.api.nvim_create_user_command("CopilotEnableBuffer", function()
    --     vim.b.copilot_enabled = true
    --     vim.notify("Copilot enabled for current buffer", vim.log.levels.INFO)
    --   end, { desc = "Enable Copilot for current buffer" })
    --
    --   vim.api.nvim_create_user_command("CopilotDisableBuffer", function()
    --     vim.b.copilot_enabled = false
    --     vim.notify("Copilot disabled for current buffer", vim.log.levels.INFO)
    --   end, { desc = "Disable Copilot for current buffer" })
    --
    --   -- Auto-commands for specific behaviors
    --   vim.api.nvim_create_augroup("CopilotCustom", { clear = true })
    --
    --   -- Auto-disable in certain buffer types
    --   vim.api.nvim_create_autocmd("FileType", {
    --     group = "CopilotCustom",
    --     pattern = { "TelescopePrompt", "oil", "neo-tree", "codecompanion" },
    --     callback = function()
    --       vim.b.copilot_enabled = false
    --     end,
    --   })
    --
    --   -- Show copilot status in command line when toggling
    --   vim.api.nvim_create_autocmd("User", {
    --     group = "CopilotCustom",
    --     pattern = "CopilotAttached",
    --     callback = function()
    --       vim.notify("Copilot attached", vim.log.levels.INFO)
    --     end,
    --   })
    --
    --   vim.api.nvim_create_autocmd("User", {
    --     group = "CopilotCustom",
    --     pattern = "CopilotDetached",
    --     callback = function()
    --       vim.notify("Copilot detached", vim.log.levels.WARN)
    --     end,
    --   })
    --
    --   -- Optional: Set up statusline integration
    --   -- You can use this in your statusline to show copilot status
    --   vim.g.copilot_status = function()
    --     local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
    --     if client == nil then
    --       return "󰚩 "
    --     end
    --
    --     if vim.tbl_isempty(client.requests) then
    --       return "󰚩 "
    --     else
    --       return "󰚩 󰄴"
    --     end
    --   end
    -- end,
  },
}
