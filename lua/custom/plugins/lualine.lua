return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 
        'nvim-tree/nvim-web-devicons',
        'Exafunction/codeium.nvim',
    },

    config = function()

        local lualine = require("lualine")
        local sections = lualine.get_config().sections
        local icons = require("icons")

        local function insert_left(section, component)
            table.insert(section, component)
        end

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(sections.lualine_c, component)
        end

        local function ins_right(component)
            table.insert(sections.lualine_x, component)
        end

        local add_cmake_tools_section = function()
            local cmake = require("cmake-tools")


            -- Credited to [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua)
            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
                end,
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
                check_git_workspace = function()
                    local filepath = vim.fn.expand("%:p:h")
                    local gitdir = vim.fn.finddir(".git", filepath .. ";")
                    return gitdir and #gitdir > 0 and #gitdir < #filepath
                end,
            }

            local colors = {
                normal = {
                    bg       = "#202328",
                    fg       = "#bbc2cf",
                    yellow   = "#ECBE7B",
                    cyan     = "#008080",
                    darkblue = "#081633",
                    green    = "#98be65",
                    orange   = "#FF8800",
                    violet   = "#a9a1e1",
                    magenta  = "#c678dd",
                    blue     = "#51afef",
                    red      = "#ec5f67",
                },
                nightfly = {
                    bg       = "#011627",
                    fg       = "#acb4c2",
                    yellow   = "#ecc48d",
                    cyan     = "#7fdbca",
                    darkblue = "#82aaff",
                    green    = "#21c7a8",
                    orange   = "#e3d18a",
                    violet   = "#a9a1e1",
                    magenta  = "#ae81ff",
                    blue     = "#82aaff ",
                    red      = "#ff5874",
                },
                light = {
                    bg       = "#f6f2ee",
                    fg       = "#3d2b5a",
                    yellow   = "#ac5402",
                    cyan     = "#287980",
                    darkblue = "#2848a9",
                    green    = "#396847",
                    orange   = "#a5222f",
                    violet   = "#8452d5",
                    magenta  = "#6e33ce",
                    blue     = "#2848a9",
                    red      = "#b3434e",
                },
                catppuccin_mocha = {
                    bg       = "#1E1E2E",
                    fg       = "#CDD6F4",
                    yellow   = "#F9E2AF",
                    cyan     = "#7fdbca",
                    darkblue = "#89B4FA",
                    green    = "#A6E3A1",
                    orange   = "#e3d18a",
                    violet   = "#a9a1e1",
                    magenta  = "#ae81ff",
                    blue     = "#89B4FA",
                    red      = "#F38BA8",
                }
            }

            colors = colors.catppuccin_mocha;

            ins_left {
                function()
                    local c_preset = cmake.get_configure_preset()
                    return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
                end,
                icon = icons.ui.Search,
                cond = function()
                    return cmake.is_cmake_project() and cmake.has_cmake_preset()
                end,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeSelectConfigurePreset")
                        end
                    end
                end
            }

            ins_left {
                function()
                    local type = cmake.get_build_type()
                    return "CMake: [" .. (type and type or "") .. "]"
                end,
                icon = icons.ui.Search,
                cond = function()
                    return cmake.is_cmake_project() and not cmake.has_cmake_preset()
                end,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeSelectBuildType")
                        end
                    end
                end
            }

            ins_left {
                function()
                    local kit = cmake.get_kit()
                    return "[" .. (kit and kit or "X") .. "]"
                end,
                icon = icons.ui.Pencil,
                cond = function()
                    return cmake.is_cmake_project() and not cmake.has_cmake_preset()
                end,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeSelectKit")
                        end
                    end
                end
            }

            ins_left {
                function()
                    return "Build"
                end,
                icon = icons.ui.Gear,
                cond = cmake.is_cmake_project,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeBuild")
                        end
                    end
                end
            }

            ins_left {
                function()
                    local b_preset = cmake.get_build_preset()
                    return "[" .. (b_preset and b_preset or "X") .. "]"
                end,
                icon = icons.ui.Search,
                cond = function()
                    return cmake.is_cmake_project() and cmake.has_cmake_preset()
                end,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeSelectBuildPreset")
                        end
                    end
                end
            }

            ins_left {
                function()
                    local b_target = cmake.get_build_target()
                    return "[" .. (b_target and b_target or "X") .. "]"
                end,
                cond = cmake.is_cmake_project,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeSelectBuildTarget")
                        end
                    end
                end
            }

            ins_left {
                function()
                    return icons.ui.Debug
                end,
                cond = cmake.is_cmake_project,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeDebug")
                        end
                    end
                end
            }

            ins_left {
                function()
                    return icons.ui.Run
                end,
                cond = cmake.is_cmake_project,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeRun")
                        end
                    end
                end
            }

            ins_left {
                function()
                    local l_target = cmake.get_launch_target()
                    return "[" .. (l_target and l_target or "X") .. "]"
                end,
                cond = cmake.is_cmake_project,
                on_click = function(n, mouse)
                    if (n == 1) then
                        if (mouse == "l") then
                            vim.cmd("CMakeSelectLaunchTarget")
                        end
                    end
                end
            }

            return sections
        end

        local add_remote_neovim_section = function()
            -- Remote Neovim
            ins_left(
                {
                    function()
                        return vim.g.remote_neovim_host and ("%s"):format(vim.g.remote_neovim_unique_host_id or vim.uv.os_gethostname()) or ""
                    end,
                    padding = { right = 1, left = 1 },
                    icon = "",
                    cond = function()
                        return vim.g.remote_neovim_host
                    end
                })
            return sections
        end

        -- Codeium
        local add_codeium_section = function()
            local codeium = require'codeium.virtual_text';
            local codeium_section = {
                function()
                    return codeium.status_string()
                end,
                cond = function()
                    return codeium ~= nil
                end,
            }
            ins_right(codeium_section)
            return sections
        end

        add_remote_neovim_section()
        -- add_cmake_tools_section()
        add_codeium_section()

        require('lualine').setup {
            sections = sections,
        }


        --
        -- -- Now don't forget to initialize lualine
        -- lualine.setup(config)
    end

}
