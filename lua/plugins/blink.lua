return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    config = function()
      local hooks = require("ibl.hooks")

      -- pakai warna theme
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4261", nocombine = true }) -- garis indent
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7", nocombine = true }) -- scope aktif
      end)

      require("ibl").setup {
        indent = {
          char = "┊",       -- garis tipis modern (bisa diganti "┆" atau "│")
          highlight = { "IblIndent" },
        },
        scope = {
          enabled = true,
          char = "│",
          highlight = { "IblScope" },
          show_start = false,
          show_end = false,
        },
        whitespace = {
          highlight = { "IblIndent" },
          remove_blankline_trail = false,
        },
      }
    end,
  },
}

