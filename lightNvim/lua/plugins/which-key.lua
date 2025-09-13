return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 300,
    icons = {
      rules = false,
      breadcrumb = " ",
      separator = "󱦰  ",
      group = "󰹍 ",
    },
    plugins = {
      spelling = {
        enabled = false,
      },
    },
    win = {
      height = {
        max = math.huge,
      },
    },
    spec = {
      {
        mode = { "n", "v" },
        -- Snacks Pickers & Explorer
        { "<leader>f", group = "Find" },
        { "<leader>fc", group = "Find" },
        { "<leader>ff", group = "Find" },
        { "<leader>fg", group = "Find" },
        { "<leader>fp", group = "Find" },
        { "<leader>fr", group = "Find" },
        { "<leader>o", group = "Find" },

        -- Git
        { "<leader>G", group = "Git" },
        { "<leader>gb", group = "Git" },
        { "<leader>gl", group = "Git" },
        { "<leader>gL", group = "Git" },
        { "<leader>gs", group = "Git" },
        { "<leader>gS", group = "Git" },
        { "<leader>gd", group = "Git" },
        { "<leader>gf", group = "Git" },
        { "<leader>gB", group = "Git" },
        { "<leader>gg", group = "Git" },

        -- Gitsigns
        { "<leader>g", group = "Gitsigns" },

        -- Replace
        { "<leader>R", group = "Replace" },

        -- LSP
        { "<leader>l", group = "LSP" },
        { "<leader>p", group = "LSP" },
        { "<leader>WS", group = "LSP" },
        { "gd", group = "LSP" },
        { "gD", group = "LSP" },
        { "gr", group = "LSP" },
        { "gI", group = "LSP" },
        { "gy", group = "LSP" },

        -- LSP (Trouble)
        { "<leader>c", group = "LSP (Trouble)" },

        -- Test
        { "<leader>t", group = "Test" },

        -- Debugger
        { "<leader>D", group = "Debugger" },

        -- Search
        { "<leader>s", group = "Search" },
        { "<leader>sb", group = "Search" },
        { "<leader>st", group = "Search" },
        { "<leader>sw", group = "Search" },
        { "<leader>sn", group = "Search" },
        { "<leader>s/", group = "Search" },
        { "<leader>sa", group = "Search" },
        { "<leader>sc", group = "Search" },
        { "<leader>sC", group = "Search" },
        { "<leader>sd", group = "Search" },
        { "<leader>sD", group = "Search" },
        { "<leader>sh", group = "Search" },
        { "<leader>sH", group = "Search" },
        { "<leader>si", group = "Search" },
        { "<leader>sj", group = "Search" },
        { "<leader>sk", group = "Search" },
        { "<leader>sl", group = "Search" },
        { "<leader>sm", group = "Search" },
        { "<leader>sM", group = "Search" },
        { "<leader>sp", group = "Search" },
        { "<leader>sq", group = "Search" },
        { "<leader>sR", group = "Search" },
        { "<leader>su", group = "Search" },
        { "<leader>uC", group = "Search" },
        { '<leader>s"', group = "Search" },

        -- diagnostics/quickfix (Trouble)
        { "<leader>x", group = "diagnostics/quickfix (Trouble)" },

        -- Toggle Features
        { "<leader>u", group = "Toggle Features" },
        { "<leader>z", group = "Toggle Features" },
        { "<leader>Z", group = "Toggle Features" },
        { "<leader>.", group = "Toggle Features" },
        { "<leader>S", group = "Toggle Features" },
        { "<leader>n", group = "Toggle Features" },
        { "<leader>un", group = "Toggle Features" },

        -- Workspace
        { "<leader>W", group = "Workspace" },

        -- prev/next
        { "[", group = "prev" },
        { "]", group = "next" },

        -- goto
        { "g", group = "goto" },

        -- Buffer
        { "<leader>b", group = "Buffer" },
        { "<tab>", group = "Buffer" },
        { "<S-tab>", group = "Buffer" },
        { "<leader>x", group = "Buffer" },
        { "Q", group = "Buffer" },
        { "<leader>cR", group = "Buffer" },

        -- Window
        { "<C-h>", group = "Window" },
        { "<C-l>", group = "Window" },
        { "<C-j>", group = "Window" },
        { "<C-k>", group = "Window" },

        -- Terminal
        { "<c-/>", group = "Terminal" },
        { "<c-_>", group = "Terminal" },
        { "<C-x>", group = "Terminal" },
        { "<leader>h", group = "Terminal" },
        { "<leader>v", group = "Terminal" },
        { "<A-v>", group = "Terminal" },
        { "<A-h>", group = "Terminal" },
        { "<A-i>", group = "Terminal" },

        -- NvimTree
        { "<C-n>", group = "NvimTree" },
        { "<leader>e", group = "NvimTree" },

        -- Comment
        { "<leader>//", group = "Comment" },

        -- Format
        { "<leader>fm", group = "Format" },

        -- Editor
        { "<Esc>", group = "Editor" },
        { "<C-s>", group = "Editor" },
        { "<C-c>", group = "Editor" },
        { "<leader>n", group = "Editor" },
        { "<leader>rn", group = "Editor" },
        { "<leader>ch", group = "Editor" },

        -- LSP diagnostic loclist
        { "<leader>ds", group = "LSP" },

        -- WhichKey
        { "<leader>wK", group = "WhichKey" },
        { "<leader>wk", group = "WhichKey" },

        -- Menu
        { "<C-t>", group = "Menu" },

        -- Mouse/Context menu
        { "<RightMouse>", group = "Mouse" },

        -- News
        { "<leader>N", group = "Other" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
