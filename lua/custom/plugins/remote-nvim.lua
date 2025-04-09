return {
  -- "amitds1997/remote-nvim.nvim",
  "remote-nvim.nvim",
  dev = true,
  version = "*", -- Pin to GitHub releases
  dependencies = {
    "nvim-lua/plenary.nvim", -- For standard functions
    "MunifTanjim/nui.nvim", -- To build the plugin UI
    "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
  },
  config = function()
    require("remote-nvim").setup(
      {
        -- You can supply your own callback that should be called to create the local client. This is the default implementation.
        -- Two arguments are passed to the callback:
        -- port: Local port at which the remote server is available
        -- workspace_config: Workspace configuration for the host. For all the properties available, see https://github.com/amitds1997/remote-nvim.nvim/blob/main/lua/remote-nvim/providers/provider.lua#L4
        -- A sample implementation using WezTerm tab is at: https://github.com/amitds1997/remote-nvim.nvim/wiki/Configuration-recipes
        client_callback = function(port, workspace_config)
          local cmd = ""
          if vim.env.TERM == "tmux-256color"
          then
            cmd = ("tmux new-window -n '%s' nvim --server localhost:%s --remote-ui"):format(
            workspace_config.host,
            port
          )
          elseif vim.env.TERM == 'wezterm' then
            cmd = ("wezterm cli set-tab-title --pane-id $(wezterm cli spawn nvim --server localhost:%s --remote-ui) %s"):format(
            port,
            ("'Remote: %s'"):format(workspace_config.host)
          )
          elseif vim.env.TERM == "xterm-kitty" then
            cmd = ("kitty -e nvim --server localhost:%s --remote-ui"):format(port)
          elseif vim.env.TERM == "xterm-256color" then
            cmd = ("gnome-terminal -- nvim --server localhost:%s --remote-ui"):format(port)
          end
          vim.fn.jobstart(cmd, {
            detach = true,
            on_exit = function(job_id, exit_code, event_type)
              -- This function will be called when the job exits
              print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
            end,
          })
        end,

        -- Remote configuration
        remote = {
          -- List of directories that should be copied over
          copy_dirs = {
            local_plugins = {
              -- home folder
              base = vim.fn.stdpath('config') .. "/lua/custom/local_plugins",
              dirs = "*",
              compression = {
                enabled = true,
              },
            },

            -- What to copy to remote's Neovim data directory
            data = {
              base = vim.fn.stdpath("data"),
              -- dirs = "*",
              dirs = nil,
              compression = {
                enabled = true,
              },
            },
            -- What to copy to remote's Neovim cache directory
            cache = {
              -- base = vim.fn.stdpath("cache"),
              -- dirs = {'codeium'},
              -- compression = {
              --   enabled = true,
              -- },
            },
          },
        }
      }
    )
  end,
}
