return {
  'Civitasv/cmake-tools.nvim',
  dependencies = { 'stevearc/overseer.nvim' },
  config = function()
    local osys = require("cmake-tools.osys")
    require("cmake-tools").setup {
      cmake_command = "cmake", -- this is used to specify cmake command path
      ctest_command = "ctest", -- this is used to specify ctest command path
      cmake_use_preset = true,
      cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1", "-GNinja" }, -- this will be passed when invoke `CMakeGenerate`
      cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
      -- support macro expansion:
      --       ${kit}
      --       ${kitGenerator}
      --       ${variant:xx}
      cmake_build_directory = function()
        require'plenary'.log.debug("cmake_build_directory windows: " .. tostring(osys.iswin32))
        -- if osys.iswin32 then
        --   print('windows')
        --   return "out\\${variant:buildType}"
        -- end
        return "build/${variant:buildType}"
      end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
      cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
      cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
      cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
      cmake_variants_message = {
        short = { show = true }, -- whether to show short message
        long = { show = true, max_length = 40 }, -- whether to show long message
      },
      cmake_executor = { -- executor to use
        name = "overseer", -- name of the executor
        opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
      },
      cmake_runner = { -- runner to use
        name = "overseer",
        opts = {},
      },
    }
  end
}
