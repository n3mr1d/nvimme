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
        { "<leader>s", group = "Search" },
        { "<leader>g", group = "Git" },
        { "<leader>u", group = "UI" },
        { "<leader>f", group = " File" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
