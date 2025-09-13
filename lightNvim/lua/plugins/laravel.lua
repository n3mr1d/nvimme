return {
  {
    "adibhanna/laravel.nvim",
    enabled = true,
    -- dir = "~/Developer/opensource/laravel.nvim",
    ft = { "php", "blade" },
    dependencies = {
      "folke/snacks.nvim", -- Optional: for enhanced UI
    },
    config = function()
      require("laravel").setup {
        notifications = false,
        debug = false,
        keymaps = true,
      }
    end,
  },
}
