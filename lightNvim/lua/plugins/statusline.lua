return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    config = function()
      -- Ambil warna dari theme yang sedang aktif di base46
      local function get_current_theme_colors()
        local ok, base46 = pcall(require, "base46")
        if ok and base46.get_theme_tb then
          local colors = base46.get_theme_tb "base_30"
          if colors then
            return colors
          end
        end

        -- fallback jika base46 tidak tersedia atau theme tidak ditemukan
        vim.notify("base46 theme not found, fallback to default lualine theme", vim.log.levels.WARN)
        return {
          black = "#1a1b26",
          white = "#c0caf5",
          darker_black = "#16161e",
          one_bg = "#222436",
          one_bg2 = "#2f334d",
          one_bg3 = "#363a4f",
          grey = "#414868",
          grey_fg = "#565f89",
          light_grey = "#6e738d",
          blue = "#7aa2f7",
          green = "#9ece6a",
          cyan = "#7dcfff",
          red = "#f7768e",
          yellow = "#e0af68",
          orange = "#ff9e64",
          magenta = "#bb9af7",
          pink = "#ff75a0",
        }
      end

      -- supaya synch dengan theme, ambil warna setiap kali config dijalankan
      local colors = get_current_theme_colors()

      local theme = {
        normal = {
          a = { fg = colors.black or "#1a1b26", bg = colors.blue or "#7aa2f7", gui = "bold" },
          b = { fg = colors.white or "#c0caf5", bg = colors.one_bg2 or "#2f334d" },
          c = { fg = colors.white or "#c0caf5", bg = colors.one_bg or "#222436" },
          z = { fg = colors.black or "#1a1b26", bg = colors.blue or "#7aa2f7" },
          x = { fg = colors.white or "#c0caf5", bg = colors.one_bg or "#222436" },
        },
        insert = { a = { fg = colors.black or "#1a1b26", bg = colors.green or "#9ece6a", gui = "bold" } },
        visual = { a = { fg = colors.black or "#1a1b26", bg = colors.magenta or "#bb9af7", gui = "bold" } },
        replace = { a = { fg = colors.black or "#1a1b26", bg = colors.red or "#f7768e", gui = "bold" } },
        command = { a = { fg = colors.black or "#1a1b26", bg = colors.yellow or "#e0af68", gui = "bold" } },
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
            table.insert(section, pos * 2, { empty, color = { fg = colors.one_bg or "#222436", bg = colors.one_bg or "#222436" } })
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

      local function active_formatter()
        local ok, conform = pcall(require, "conform")
        if not ok then
          return ""
        end
        local formatters = conform.list_formatters(0)
        if #formatters == 0 then
          return "NoFmt"
        end
        local names = {}
        for _, f in ipairs(formatters) do
          table.insert(names, f.name)
        end
        return " 󰉿 " .. table.concat(names, ",")
      end

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
              color = { fg = colors.white or "#c0caf5", bg = colors.one_bg2 or "#2f334d", gui = "bold" },
              separator = { right = "" },
              padding = { left = 1, right = 1 },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn", "info", "hint" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
              diagnostics_color = {
                error = { fg = colors.red or "#f7768e" },
                warn = { fg = colors.yellow or "#e0af68" },
                info = { fg = colors.blue or "#7aa2f7" },
                hint = { fg = colors.cyan or "#7dcfff" },
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
              linter_status,
              color = { fg = colors.white or "#c0caf5", bg = colors.one_bg or "#222436", gui = "bold" },
              padding = { left = 1, right = 1 },
            },
            {
              active_formatter,
              color = { fg = colors.white or "#c0caf5", bg = colors.one_bg or "#222436", gui = "bold" },
            },
            {
              "filetype",
              color = { fg = colors.white or "#c0caf5", bg = colors.one_bg or "#222436", gui = "bold" },
              padding = { left = 1, right = 1 },
              separator = { right = "" },
            },
            {
              "fileformat",
              color = { fg = colors.white or "#c0caf5", bg = colors.one_bg2 or "#2f334d", gui = "bold" },
              padding = { left = 1, right = 1 },
            },
            {
              "encoding",
              color = { fg = colors.white or "#c0caf5", bg = colors.one_bg2 or "#2f334d", gui = "bold" },
              padding = { left = 1, right = 1 },
              separator = { right = "" },
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

      -- Optional: listen to theme change event (if your theme plugin emits one) and reload lualine
      -- This is a simple example for base46, you may need to adapt for your setup
      if package.loaded["base46"] then
        vim.api.nvim_create_autocmd("User", {
          pattern = "Base46ThemeChanged",
          callback = function()
            -- reload colors and re-setup lualine
            local new_colors = get_current_theme_colors()
            -- update theme table
            theme.normal.a.bg = new_colors.blue or "#7aa2f7"
            theme.normal.a.fg = new_colors.black or "#1a1b26"
            theme.normal.b.bg = new_colors.one_bg2 or "#2f334d"
            theme.normal.b.fg = new_colors.white or "#c0caf5"
            theme.normal.c.bg = new_colors.one_bg or "#222436"
            theme.normal.c.fg = new_colors.white or "#c0caf5"
            theme.normal.z.bg = new_colors.blue or "#7aa2f7"
            theme.normal.z.fg = new_colors.black or "#1a1b26"
            theme.normal.x.bg = new_colors.one_bg or "#222436"
            theme.normal.x.fg = new_colors.white or "#c0caf5"
            theme.insert.a.bg = new_colors.green or "#9ece6a"
            theme.insert.a.fg = new_colors.black or "#1a1b26"
            theme.visual.a.bg = new_colors.magenta or "#bb9af7"
            theme.visual.a.fg = new_colors.black or "#1a1b26"
            theme.replace.a.bg = new_colors.red or "#f7768e"
            theme.replace.a.fg = new_colors.black or "#1a1b26"
            theme.command.a.bg = new_colors.yellow or "#e0af68"
            theme.command.a.fg = new_colors.black or "#1a1b26"
            require("lualine").setup({
              options = {
                theme = theme,
                globalstatus = true,
                component_separators = "",
                section_separators = { left = "", right = "" },
                disabled_filetypes = { statusline = { "snacks_dashboard", "alpha", "dashboard", "snacks_layout_box" } },
              },
              -- sections, inactive_sections, extensions, etc. can be reused as above
            })
          end,
        })
      end
    end,
  },
}
