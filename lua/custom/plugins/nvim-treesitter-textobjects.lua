return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true, -- Only loaded when treesitter loads (since it is specified as a dependency of treesitter)
  config = function()
    ---@diagnostic disable: missing-fields
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "[TS] Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "[TS] Select inner part of an assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "[TS] Select left hand side of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "[TS] Select right hand side of an assignment" },

            ["aa"] = { query = "@parameter.outer", desc = "[TS] Select outer part of a parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "[TS] Select inner part of a parameter/argument" },

            ["ai"] = { query = "@conditional.outer", desc = "[TS] Select outer part of a conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "[TS] Select inner part of a conditional" },

            ["al"] = { query = "@loop.outer", desc = "[TS] Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "[TS] Select inner part of a loop" },

            ["af"] = { query = "@call.outer", desc = "[TS] Select outer part of a function call" },
            ["if"] = { query = "@call.inner", desc = "[TS] Select inner part of a function call" },

            ["am"] = { query = "@function.outer", desc = "[TS] Select outer part of a method/function definition" },
            ["im"] = { query = "@function.inner", desc = "[TS] Select inner part of a method/function definition" },

            ["ac"] = { query = "@class.outer", desc = "[TS] Select outer part of a class" },
            ["ic"] = { query = "@class.inner", desc = "[TS] Select inner part of a class" },
          },
        },


        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = { query = "@call.outer", desc = "[TS] Next function call start" },
            ["]m"] = { query = "@function.outer", desc = "[TS] Next method/function def start" },
            ["]c"] = { query = "@class.outer", desc = "[TS] Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "[TS] Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "[TS] Next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "[TS] Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "[TS] Next fold" },
          },
          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "[TS] Next function call end" },
            ["]M"] = { query = "@function.outer", desc = "[TS] Next method/function def end" },
            ["]C"] = { query = "@class.outer", desc = "[TS] Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "[TS] Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "[TS] Next loop end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@call.outer", desc = "[TS] Prev function call start" },
            ["[m"] = { query = "@function.outer", desc = "[TS] Prev method/function def start" },
            ["[c"] = { query = "@class.outer", desc = "[TS] Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "[TS] Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "[TS] Prev loop start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "[TS] Prev function call end" },
            ["[M"] = { query = "@function.outer", desc = "[TS] Prev method/function def end" },
            ["[C"] = { query = "@class.outer", desc = "[TS] Prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "[TS] Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "[TS] Prev loop end" },
          },
        },

        swap = {
          enable = true,
          swap_next = {
            ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
            ["<leader>nm"] = "@function.outer", -- swap function with next
          },
          swap_previous = {
            ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
            ["<leader>pm"] = "@function.outer", -- swap function with previous
          },
        },
      },
    })
  end
}
