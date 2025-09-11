return {
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        -- HEADER ASCII
        header = {
          "    ____  __            __        __         ",
          "   / __ \\/ /___  ____  / /_____ _/ /_  ___ _ ",
          "  / /_/ / / __ \\/ __ \\/ __/ __ `/ __ \\/ _ `/ ",
          " / ____/ / /_/ / /_/ / /_/ /_/ / /_/ /  __/  ",
          "/_/   /_/ .___/ .___/\\__/\\__,_/_.___/\\___/   ",
          "       /_/   /_/                              ",
        },

        -- SECTIONS
        sections = {
          section = "header",
          padding = { 1, 1 },

          {
            section = "keys",
            title = "  Shortcuts",
            indent = 2,
            padding = { 1, 1 },
          },

          {
            section = "recent_files",
            title = "  Recent Files",
            icon = "",
            indent = 2,
            padding = { 1, 1 },
          },
          {
            section = "projects",
            title = "  Projects",
            icon = "",
            indent = 2,
            padding = { 1, 1 },
          },
        },

        -- Gaya umum
        section_padding = 1, -- jarak antar section
        highlight = "Normal", -- warna default section
      },
    },
  },
}
