return {
  --'Civitasv/cmake-tools.nvim',
  'cmake-tools.nvim',
  dev=true,
  dependencies =
    {
      'stevearc/overseer.nvim',
      'folke/which-key.nvim'
    },
  config = function()
    require("cmake-tools").setup {
      cmake_command = "cmake", -- this is used to specify cmake command path
      ctest_command = "ctest", -- this is used to specify ctest command path
      cmake_use_preset = true,
      cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
      -- cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-GNinja", " -DCMAKE_C_COMPILER_LAUNCHER=ccache", "-DCMAKE_CXX_COMPILER_LAUNCHER=ccache" }, -- this will be passed when invoke `CMakeGenerate`
      cmake_generate_options = {},
      cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
      cmake_build_disable_config = true,
      -- support macro expansion:
      --       ${kit}
      --       ${kitGenerator}
      --       ${variant:xx}
      cmake_build_directory = function()
        return "build/${variant:buildType}"
      end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
      cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
      cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
      cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
      cmake_variants_message = {
        short = { show = false }, -- whether to show short message
        long = { show = false, max_length = 40 }, -- whether to show long message
      },
      cmake_executor = { -- executor to use
        name = "overseer", -- name of the executor
        opts =
        {
            new_task_opts = {
              strategy = {
                "toggleterm",
                direction = "horizontal",
                auto_scroll = true,
                quit_on_exit = "success"
              }
            }, -- options to pass into the `overseer.new_task` command
            on_new_task = function(task)
              require("overseer").open(
                { enter = false, direction = "right" }
              )
            end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
          },
      },
      cmake_runner = { -- runner to use
        name = "overseer",
        opts = {},
      },
    }

    local wk = require("which-key")
    wk.add(
      {
        { "<leader>cc", desc = "[C]make" },
        { "<leader>ccp", desc = "[C]make Select [P]reset" },
        { "<leader>ccpc", ":CMakeSelectConfigurePreset<CR>", desc = "[C]make Select [P]reset [C]onfigure"},
        { "<leader>ccpb", ":CMakeSelectBuildPreset<CR>", desc = "[C]make Select [P]reset [B]uild"},
        { "<leader>ccg", ":CMakeGenerate<CR>", desc = "[C]make [G]enerate"},
        { "<leader>ccb", ":CMakeBuild<CR>", desc = "[C]make [B]uild"},
      }
    )
  end
}
