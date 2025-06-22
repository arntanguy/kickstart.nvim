return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
    { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    "folke/which-key.nvim",
    "echasnovski/mini.diff"
  },
  keys = {
    -- Global keymaps
    {
      "<leader>aa",
      "<cmd>CodeCompanionActions<cr>",
      mode = { "n", "v" },
      desc = "[A]I [A]ctions"
    },
    {
      "<leader>ac",
      "<cmd>CodeCompanionChat Toggle<cr>",
      mode = { "n", "v" },
      desc = "[A]I [C]hat Toggle"
    },
    {
      "<leader>ae",
      "<cmd>CodeCompanionChat Add<cr>",
      mode = "v",
      desc = "[A]I Chat [E]xplain Selection"
    },
    {
      "<leader>an",
      "<cmd>CodeCompanionChat<cr>",
      mode = "n",
      desc = "[A]I [N]ew Chat"
    },
    {
      "<leader>ai",
      "<cmd>CodeCompanion<cr>",
      mode = { "n", "v" },
      desc = "[A]I [I]nline Assistant"
    },
    {
      "<leader>aq",
      "<cmd>CodeCompanionCmd<cr>",
      mode = "n",
      desc = "[A]I [Q]uick Command"
    },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },
      adapters = {
        opts = {
              show_defaults = false,
        },
        -- Paid
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              -- Or set ANTHROPIC_API_KEY in your environment
              -- api_key = "ANTHROPIC_API_KEY",
            },
          })
        end,
        -- Virtually free, but no hard limit
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                -- default = "gemini-2.5-flash-preview-05-20"
              },
            },
            env = {
              -- FIXME: do not store as open secret
              -- Or set GEMINI_API_KEY in your environment
            },
          })
        end,
        -- Unlimited claude sonnet use including chat for 10$/month
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                -- default = "claude-3.5-sonnet",
                -- default = "claude-sonnet-4-20250514",
              },
            },
          })
        end,
        -- local LLM
        tabby = function()
           return require("codecompanion.adapters").extend("openai_compatible", {
             env = {
               -- Use tabby local llm
               url = "http://localhost:8080", -- optional: default value is ollama url http://127.0.0.1:11434
               chat_url = "/v1/chat/completions", -- optional: default value, override if different
             },
             schema = {
               model = {
                 -- default = "Qwen2-1.5B-Instruct",
                 default = "Qwen2.5-Coder-14B",
                 -- default = "Qwen2-1.5B-Instruct",
                 choices = { "Qwen2.5-Coder-14B", "Qwen2-1.5B-Instruct" },
               },
             },
           })
        end,
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
        },
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
          },
        },
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "default", -- default|mini_diff
        },
      },
    })

    -- Register the AI group with WhichKey
    local wk = require("which-key")
    wk.add({
      { "<leader>a", group = "[A]I Assistant", icon = "🤖" },
      { "<leader>a_", hidden = true },
    })
  end,
}
