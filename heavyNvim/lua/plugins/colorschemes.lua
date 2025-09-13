return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- langsung load saat startup
    priority = 1000, -- agar colorscheme di-load dulu sebelum plugin lain
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
      vim.api.nvim_set_hl(0, "Visual", { bg = "#5a5a5a" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#ff00ff", fg = "#000000" })
      -- Highlight untuk selected item di menu cmp
      vim.api.nvim_set_hl(0, "CmpSel", { bg = "#3e4452", fg = "#ffffff", bold = true })
    end,
  },
}
