return {
  {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim" },
  config = function()
    local colors = require("tokyonight.colors").setup()

    local theme = {
      normal = {
        a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
        b = { fg = colors.fg, bg = colors.bg_highlight },
        c = { fg = colors.fg, bg = colors.bg },
        z = { fg = colors.bg, bg = colors.blue },
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

    -- Show active LSP clients
    local function lsp_clients()
      local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if #buf_clients == 0 then
        return "No LSP"
      end
      local names = {}
      for _, client in pairs(buf_clients) do
        table.insert(names, client.name)
      end
      return " " .. table.concat(names, ", ")
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
      local searchcount = vim.fn.searchcount { maxcount = 9999 }
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
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "snacks_dashboard", "alpha" , "dashboard","snacks_layout_box"} },
      },
      sections = process_sections({
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
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
         {
    lsp_clients,
    color = { fg = colors.bg, bg = colors.green, gui = "bold" }, -- bikin block dengan warna
    separator = { right = "" }, -- kasih powerline segmen
    padding = { left = 1, right = 1 },
  },
        },
        lualine_x = {
          search_result,
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }),
      inactive_sections = {
        lualine_c = { "%f %y %m" },
        lualine_x = {},
      },
        extensions = { "nvim-tree" }
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
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          theme = "tokyonight",
          separator_style = "slant",
          offsets = {
            {
              filetype = "snacks_explorer", 
              text = "Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
    end,
  },
}

