return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim" },
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    config = function()
      local colors = require("tokyonight.colors").setup()
      local custom = {
        bg = "#1a1b26",
        fg = "#c0caf5",
        bg_highlight = "#292e42",
        blue = "#7aa2f7",
        green = "#9ece6a",
        magenta = "#bb9af7",
        red = "#f7768e",
        yellow = "#e0af68",
      }
      local theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
          b = { fg = colors.fg, bg = colors.bg_highlight },
          c = { fg = colors.fg, bg = colors.bg },
          z = { fg = colors.bg, bg = colors.blue },
          x = { fg = colors.fg, bg = colors.bg },
        },
        insert = { a = { fg = colors.bg, bg = colors.green, gui = "bold" } },
        visual = { a = { fg = colors.bg, bg = colors.magenta, gui = "bold" } },
        replace = { a = { fg = colors.bg, bg = colors.red, gui = "bold" } },
        command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
      }

      local empty = require("lualine.component"):extend()
      function empty:draw(default_highlight)
        self.status = ""
        self.applied_separator = ""
        self:apply_highlights(default_highlight)
        self:apply_section_separators()
        return self.status
      end

      local function process_sections(sections)
        for name, section in pairs(sections) do
          local left = name:sub(9, 10) < "x"
          for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
            table.insert(section, pos * 2, { empty, color = { fg = colors.bg, bg = colors.bg } })
          end
          for id, comp in ipairs(section) do
            if type(comp) ~= "table" then
              comp = { comp }
              section[id] = comp
            end
            comp.separator = left and { right = "" } or { left = "" }
          end
        end
        return sections
      end
      local function linter_status()
        local ok, lint = pcall(require, "lint")
        if not ok then
          return ""
        end

        local linters = lint.linters_by_ft[vim.bo.filetype] or {}
        if #linters == 0 then
          return ""
        end

        return "󰁨 " .. table.concat(linters, ",")
      end
      -- Show active LSP clients
      local function lsp_clients()
        local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
        if #buf_clients == 0 then
          return "No LSP"
        end

        local exclude = { "copilot", "null-ls" }
        local names = {}

        for _, client in ipairs(buf_clients) do
          if not vim.tbl_contains(exclude, client.name) then
            table.insert(names, client.name)
          end
        end

        if #names == 0 then
          return "No LSP"
        end

        return " " .. table.concat(names, ", ")
      end
      -- function untuk dapetin formatter aktif
      local function active_formatter()
        local conform = require("conform")
        local formatters = conform.list_formatters(0) -- 0 = current buffer
        if #formatters == 0 then
          return "NoFmt"
        end
        local names = {}
        for _, f in ipairs(formatters) do
          table.insert(names, f.name)
        end
        return " 󰉿 " .. table.concat(names, ",")
      end
      -- Show search results
      local function search_result()
        if vim.v.hlsearch == 0 then
          return ""
        end
        local last_search = vim.fn.getreg("/")
        if not last_search or last_search == "" then
          return ""
        end
        local searchcount = vim.fn.searchcount({ maxcount = 9999 })
        return " " .. last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
      end

      -- Show modified / readonly
      local function modified()
        if vim.bo.modified then
          return "[+]"
        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
          return ""
        end
        return ""
      end

      require("lualine").setup({
        options = {
          theme = theme,
          globalstatus = true,
          component_separators = "",
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "snacks_dashboard", "alpha", "dashboard", "snacks_layout_box" } },
        },
        sections = process_sections({
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            {
              lsp_clients,
              color = { fg = colors.fg, bg = colors.bg_highlight, gui = "bold" }, -- bikin block dengan warna
              separator = { right = "" }, -- kasih powerline segmen
              padding = { left = 1, right = 1 },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn", "info", "hint" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
              diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.blue },
                hint = { fg = colors.cyan },
              },
            },
          },
          lualine_c = {
            { "filename", path = 1 },
            modified,
          },
          lualine_x = {
            search_result,
            {
              "encoding",
              color = { fg = colors.fg, bg = custom.bg, gui = "bold" },
              padding = { left = 1, right = 1 },
            },
            {
              "fileformat",
              color = { fg = colors.fg, bg = custom.bg, gui = "bold" },
            },
            {
              "filetype",
              color = { fg = colors.fg, bg = custom.bg, gui = "bold" },
              padding = { left = 1, right = 1 },
              separator = { right = "" },
            },
            {
              linter_status,
              color = { fg = colors.fg, bg = colors.bg_highlight, gui = "bold" },
              padding = { left = 1, right = 1 },
            },
            {
              active_formatter,
              color = { fg = colors.fg, bg = colors.bg_highlight, gui = "bold" },
              padding = { left = 1, right = 1 },
              separator = { right = "" }, -- ✅ block terakhir punya pemisah
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        }),
        inactive_sections = {
          lualine_c = { "%f %y %m" },
          lualine_x = {},
        },
        extensions = { "nvim-tree" },
      })
    end,
  },

  -- =========================
  -- BUFFERLINE with Snacks offset
  -- =========================
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          offsets = {
            {
              filetype = "NvimTree",
              text = "Nvim Tree",
              text_align = "left",
            },
          },

          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          theme = "tokyonight",
          separator_style = "slant",
        },
      })
    end,
  },
}
