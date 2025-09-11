return {
  -- Modern cursorline
  {
    "yamatsum/nvim-cursorline",
    event = "VeryLazy",
    opts = {
      cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true, bg = "#2a2a2a" },
      },
    },
  },
  -- Alternatif ringan: mini.cursorword
  {
    "echasnovski/mini.cursorword",
    event = "BufReadPost",
    opts = {
      delay = 100,
      hl = { underline = true, bg = "#2a2a2a" },
    },
  },
}
