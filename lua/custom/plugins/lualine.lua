return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 
        'nvim-tree/nvim-web-devicons',
        'Exafunction/codeium.nvim',
    },
    config = function()
        local sections = require'lualine'.get_config().sections

        local function insert_left(section, component)
            table.insert(section, component)
        end

        -- Remote Neovim
        insert_left(sections.lualine_a,
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

        -- Codeium
        local codeium = require'codeium.virtual_text';
        local codeium_section = {
            function()
                return codeium.status_string()
            end,
            cond = function()
                return codeium ~= nil
            end,
        }

        insert_left(sections.lualine_x, codeium_section)

        require('lualine').setup {
            sections = sections,
        }
    end,

}
