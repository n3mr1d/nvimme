return {
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[




▗▄▄▄  ▗▞▀▚▖▄   ▄ ▗▞▀▚▖█  ▄▄▄  ▄▄▄▄  ▗▞▀▚▖ ▄▄▄ 
▐▌  █ ▐▛▀▀▘█   █ ▐▛▀▀▘█ █   █ █   █ ▐▛▀▀▘█    
▐▌  █ ▝▚▄▄▖ ▀▄▀  ▝▚▄▄▖█ ▀▄▄▄▀ █▄▄▄▀ ▝▚▄▄▖█    
▐▙▄▄▀                 █       █               
                              ▀               


       Made by N3mr4iD 󰵮  with ❤

]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            -- File Operations
            { icon = " ", key = "f", desc = "Find File",        action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File",         action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text",        action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files",     action = ":lua Snacks.dashboard.pick('oldfiles')" },
            
            -- Config & Session
            { icon = " ", key = "c", desc = "Config",           action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },

            -- Package / Lazy
            { icon = " ", key = "x", desc = "Lazy Extras",      action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",             action = ":Lazy" },

            -- Utilities
            { icon = " ", key = "q", desc = "Quit",             action = ":qa" },


          },
        },
      },
    },
  },
}
