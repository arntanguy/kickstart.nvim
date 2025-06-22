return {
    'gbprod/yanky.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    event = 'VeryLazy',
    config = function()
        local yanky = require('yanky')
        local telescope_ok, telescope = pcall(require, 'telescope')

        yanky.setup({
            ring = {
                history_length = 100,
                storage = "shada",
                sync_with_numbered_registers = true,
                cancel_event = "update",
                ignore_registers = { "_" },
                update_register_on_cycle = false,
            },
            picker = {
                telescope = {
                    use_default_mappings = true,
                },
            },
            system_clipboard = { sync_with_ring = true },
            highlight = { on_put = true, on_yank = true, timer = 500 },
            preserve_cursor_position = { enabled = true },
            textobj = { enabled = true },
        })

        -- Error handling for Telescope yank_history extension
        if telescope_ok then
            local success, err = pcall(telescope.load_extension, 'yank_history')
            if not success then
                vim.notify("Failed to load Telescope yank_history extension: " .. err, vim.log.levels.ERROR)
            end
        else
            vim.notify("Telescope not found: " .. telescope, vim.log.levels.ERROR)
        end

        -- Clipboard configuration
        --
        -- Check terminals that support OSC52
        local function is_osc52_safe()
            local term = vim.env.TERM or ""
            local safe_terms = { "tmux", "wezterm", "alacritty", "kitty", "iTerm" }
            for _, t in ipairs(safe_terms) do
                if term:find(t) then return true end
            end
            return false
        end

        -- Prefer using OSC52
        if is_osc52_safe() then
            local osc52 = require('vim.ui.clipboard.osc52')
            vim.g.clipboard = {
                name = 'OSC52',
                copy = {
                    ['+'] = osc52.copy('+'),
                    ['*'] = osc52.copy('*'),
                },
                paste = {
                    ['+'] = osc52.paste('+'),
                    ['*'] = osc52.paste('*'),
                },
            }
        else
            -- fallback to using xclip/xsel if not supported
            if vim.fn.executable('xclip') == 1 then
                vim.g.clipboard = {
                    name = 'xclip',
                    copy = {
                        ['+'] = 'xclip -selection clipboard',
                        ['*'] = 'xclip -selection primary',
                    },
                    paste = {
                        ['+'] = 'xclip -selection clipboard -o',
                        ['*'] = 'xclip -selection primary -o',
                    },
                }
            elseif vim.fn.executable('xsel') == 1 then
                vim.g.clipboard = {
                    name = 'xsel',
                    copy = {
                        ['+'] = 'xsel --clipboard --input',
                        ['*'] = 'xsel --primary --input',
                    },
                    paste = {
                        ['+'] = 'xsel --clipboard --output',
                        ['*'] = 'xsel --primary --output',
                    },
                }
            else
                vim.g.clipboard = nil -- No system clipboard integration available
            end
        end
    end
}
