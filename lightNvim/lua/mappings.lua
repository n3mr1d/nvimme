-- Keymap groups for clarity and deduplication
local map = vim.keymap.set

-- Snacks Pickers & Explorer
local snacks_picker = {
  -- Top Pickers & Explorer
  {
    "<leader><space>",
    function()
      Snacks.picker.smart()
    end,
    desc = "Smart Find Files",
  },
  {
    "<leader>/",
    function()
      Snacks.picker.grep()
    end,
    desc = "Grep",
  },
  {
    "<leader>:",
    function()
      Snacks.picker.command_history()
    end,
    desc = "Command History",
  },
  {
    "<leader>sn",
    function()
      Snacks.picker.notifications()
    end,
    desc = "Search Notifications",
  },

  -- Find
  {
    "<leader>o",
    function()
      Snacks.picker.buffers {
        win = {
          input = {
            keys = {
              ["dd"] = "bufdelete",
              ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
            },
          },
          list = { keys = { ["dd"] = "bufdelete" } },
        },
      }
    end,
    desc = "Buffers",
  },
  {
    "<leader>fc",
    function()
      Snacks.picker.files { cwd = vim.fn.stdpath "config" }
    end,
    desc = "Find Config File",
  },
  {
    "<leader>ff",
    function()
      Snacks.picker.files()
    end,
    desc = "Find Files",
  },
  {
    "<leader>fg",
    function()
      Snacks.picker.git_files()
    end,
    desc = "Find Git Files",
  },
  {
    "<leader>fp",
    function()
      Snacks.picker.projects()
    end,
    desc = "Projects",
  },
  {
    "<leader>fr",
    function()
      Snacks.picker.recent()
    end,
    desc = "Recent",
  },

  -- Git
  {
    "<leader>gb",
    function()
      Snacks.picker.git_branches()
    end,
    desc = "Git Branches",
  },
  {
    "<leader>gl",
    function()
      Snacks.picker.git_log()
    end,
    desc = "Git Log",
  },
  {
    "<leader>gL",
    function()
      Snacks.picker.git_log_line()
    end,
    desc = "Git Log Line",
  },
  {
    "<leader>gs",
    function()
      Snacks.picker.git_status()
    end,
    desc = "Git Status",
  },
  {
    "<leader>gS",
    function()
      Snacks.picker.git_stash()
    end,
    desc = "Git Stash",
  },
  {
    "<leader>gd",
    function()
      Snacks.picker.git_diff()
    end,
    desc = "Git Diff (Hunks)",
  },
  {
    "<leader>gf",
    function()
      Snacks.picker.git_log_file()
    end,
    desc = "Git Log File",
  },

  -- Grep
  {
    "<leader>sb",
    function()
      Snacks.picker.lines()
    end,
    desc = "Buffer Lines",
  },
  {
    "<C-s>",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "Grep Open Buffers",
  },
  {
    "<leader>st",
    function()
      Snacks.picker.grep()
    end,
    desc = "Grep",
  },
  {
    "<leader>sw",
    function()
      Snacks.picker.grep_word()
    end,
    desc = "Visual selection or word",
    mode = { "n", "x" },
  },

  -- Search
  {
    '<leader>s"',
    function()
      Snacks.picker.registers()
    end,
    desc = "Registers",
  },
  {
    "<leader>s/",
    function()
      Snacks.picker.search_history()
    end,
    desc = "Search History",
  },
  {
    "<leader>sa",
    function()
      Snacks.picker.autocmds()
    end,
    desc = "Autocmds",
  },
  {
    "<leader>sc",
    function()
      Snacks.picker.command_history()
    end,
    desc = "Command History",
  },
  {
    "<leader>sC",
    function()
      Snacks.picker.commands()
    end,
    desc = "Commands",
  },
  {
    "<leader>sd",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "Diagnostics",
  },
  {
    "<leader>sD",
    function()
      Snacks.picker.diagnostics_buffer()
    end,
    desc = "Buffer Diagnostics",
  },
  {
    "<leader>sh",
    function()
      Snacks.picker.help()
    end,
    desc = "Help Pages",
  },
  {
    "<leader>sH",
    function()
      Snacks.picker.highlights()
    end,
    desc = "Highlights",
  },
  {
    "<leader>si",
    function()
      Snacks.picker.icons()
    end,
    desc = "Icons",
  },
  {
    "<leader>sj",
    function()
      Snacks.picker.jumps()
    end,
    desc = "Jumps",
  },
  {
    "<leader>sk",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "Keymaps",
  },
  {
    "<leader>sl",
    function()
      Snacks.picker.loclist()
    end,
    desc = "Location List",
  },
  {
    "<leader>sm",
    function()
      Snacks.picker.marks()
    end,
    desc = "Marks",
  },
  {
    "<leader>sM",
    function()
      Snacks.picker.man()
    end,
    desc = "Man Pages",
  },
  {
    "<leader>sp",
    function()
      Snacks.picker.lazy()
    end,
    desc = "Search for Plugin Spec",
  },
  {
    "<leader>sq",
    function()
      Snacks.picker.qflist()
    end,
    desc = "Quickfix List",
  },
  {
    "<leader>sR",
    function()
      Snacks.picker.resume()
    end,
    desc = "Resume",
  },
  {
    "<leader>su",
    function()
      Snacks.picker.undo()
    end,
    desc = "Undo History",
  },
  {
    "<leader>uC",
    function()
      Snacks.picker.colorschemes()
    end,
    desc = "Colorschemes",
  },

  -- LSP
  {
    "gd",
    function()
      Snacks.picker.lsp_definitions()
    end,
    desc = "Goto Definition",
  },
  {
    "gD",
    function()
      Snacks.picker.lsp_declarations()
    end,
    desc = "Goto Declaration",
  },
  {
    "gr",
    function()
      Snacks.picker.lsp_references()
    end,
    nowait = true,
    desc = "References",
  },
  {
    "gI",
    function()
      Snacks.picker.lsp_implementations()
    end,
    desc = "Goto Implementation",
  },
  {
    "gy",
    function()
      Snacks.picker.lsp_type_definitions()
    end,
    desc = "Goto T[y]pe Definition",
  },
  {
    "<leader>p",
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = "LSP Symbols",
  },
  {
    "<leader>WS",
    function()
      Snacks.picker.lsp_workspace_symbols()
    end,
    desc = "LSP Workspace Symbols",
  },

  -- Other
  {
    "<leader>z",
    function()
      Snacks.zen()
    end,
    desc = "Toggle Zen Mode",
  },
  {
    "<leader>Z",
    function()
      Snacks.zen.zoom()
    end,
    desc = "Toggle Zoom",
  },
  {
    "<leader>.",
    function()
      Snacks.scratch()
    end,
    desc = "Toggle Scratch Buffer",
  },
  {
    "<leader>S",
    function()
      Snacks.scratch.select()
    end,
    desc = "Select Scratch Buffer",
  },
  {
    "<leader>n",
    function()
      Snacks.notifier.show_history()
    end,
    desc = "Notification History",
  },
  {
    "Q",
    function()
      Snacks.bufdelete()
    end,
    desc = "Delete Buffer",
  },
  {
    "<leader>cR",
    function()
      Snacks.rename.rename_file()
    end,
    desc = "Rename File",
  },
  {
    "<leader>gB",
    function()
      Snacks.gitbrowse()
    end,
    desc = "Git Browse",
    mode = { "n", "v" },
  },
  {
    "<leader>gg",
    function()
      Snacks.lazygit()
    end,
    desc = "Lazygit",
  },
  {
    "<leader>un",
    function()
      Snacks.notifier.hide()
    end,
    desc = "Dismiss All Notifications",
  },
  {
    "<c-/>",
    function()
      Snacks.terminal()
    end,
    desc = "Toggle Terminal",
  },
  {
    "<c-_>",
    function()
      Snacks.terminal()
    end,
    desc = "which_key_ignore",
  },
  {
    "]]",
    function()
      Snacks.words.jump(vim.v.count0)
    end,
    desc = "Next Reference",
    mode = { "n", "t" },
  },
  {
    "[[",
    function()
      Snacks.words.jump(-vim.v.count0)
    end,
    desc = "Prev Reference",
    mode = { "n", "t" },
  },
  {
    "<leader>N",
    function()
      Snacks.win {
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[0],
        width = -1.6,
        height = -1.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = "yes",
          statuscolumn = " ",
          conceallevel = 2,
        },
      }
    end,
    desc = "Neovim News",
  },
}

for _, m in ipairs(snacks_picker) do
  -- Determine mode: use m.mode if present, else default to "n"
  local mode = (type(m.mode) ~= "nil") and m.mode or "n"
  -- Remove mode from opts to avoid passing it as a key
  local opts = {}
  for k, v in pairs(m) do
    if k ~= 1 and k ~= 2 and k ~= "mode" then
      opts[k] = v
    end
  end
  map(mode, m[1], m[2], opts)
end

-- Editor/Window/Buffer/Terminal/Comment/WhichKey/Mouse/Other
local editor_mappings = {
  -- Insert mode navigation
  { mode = "i", lhs = "<C-b>", rhs = "<ESC>^i", desc = "Move beginning of line" },
  { mode = "i", lhs = "<C-e>", rhs = "<End>", desc = "Move end of line" },
  { mode = "i", lhs = "<C-h>", rhs = "<Left>", desc = "Move left" },
  { mode = "i", lhs = "<C-l>", rhs = "<Right>", desc = "Move right" },
  { mode = "i", lhs = "<C-j>", rhs = "<Down>", desc = "Move down" },
  { mode = "i", lhs = "<C-k>", rhs = "<Up>", desc = "Move up" },

  -- Window navigation
  { mode = "n", lhs = "<C-h>", rhs = "<C-w>h", desc = "Switch window left" },
  { mode = "n", lhs = "<C-l>", rhs = "<C-w>l", desc = "Switch window right" },
  { mode = "n", lhs = "<C-j>", rhs = "<C-w>j", desc = "Switch window down" },
  { mode = "n", lhs = "<C-k>", rhs = "<C-w>k", desc = "Switch window up" },

  -- General
  { mode = "n", lhs = "<C-s>", rhs = "<cmd>w<CR>", desc = "Save file" },
  { mode = "n", lhs = "<C-c>", rhs = "<cmd>%y+<CR>", desc = "Copy whole file" },
  { mode = "n", lhs = "<leader>n", rhs = "<cmd>set nu!<CR>", desc = "Toggle line number" },
  { mode = "n", lhs = "<leader>rn", rhs = "<cmd>set rnu!<CR>", desc = "Toggle relative number" },
  { mode = "n", lhs = "<leader>ch", rhs = "<cmd>NvCheatsheet<CR>", desc = "Toggle nvcheatsheet" },

  -- Format
  {
    mode = { "n", "x" },
    lhs = "<leader>fm",
    rhs = function()
      require("conform").format { lsp_fallback = true }
    end,
    desc = "Format file",
  },

  -- LSP
  { mode = "n", lhs = "<leader>ds", rhs = vim.diagnostic.setloclist, desc = "LSP diagnostic loclist" },

  -- Buffer/Tab
  { mode = "n", lhs = "<leader>b", rhs = "<cmd>enew<CR>", desc = "Buffer new" },
  {
    mode = "n",
    lhs = "<tab>",
    rhs = function()
      require("nvchad.tabufline").next()
    end,
    desc = "Buffer goto next",
  },
  {
    mode = "n",
    lhs = "<S-tab>",
    rhs = function()
      require("nvchad.tabufline").prev()
    end,
    desc = "Buffer goto prev",
  },
  {
    mode = "n",
    lhs = "<leader>x",
    rhs = function()
      require("nvchad.tabufline").close_buffer()
    end,
    desc = "Buffer close",
  },

  -- Comment
  { mode = "n", lhs = "<leader>//", rhs = "gcc", desc = "Toggle comment", remap = true },
  { mode = "v", lhs = "<leader>//", rhs = "gc", desc = "Toggle comment", remap = true },

  -- NvimTree
  { mode = "n", lhs = "<leader>e", rhs = "<cmd>NvimTreeToggle<CR>", desc = "NvimTree toggle window" },
  { mode = "n", lhs = "<C-n>", rhs = "<cmd>NvimTreeFocus<CR>", desc = "NvimTree focus window" },

  -- Terminal
  { mode = "t", lhs = "<C-x>", rhs = "<C-\\><C-N>", desc = "Escape terminal mode" },
  {
    mode = "n",
    lhs = "<leader>h",
    rhs = function()
      require("nvchad.term").new { pos = "sp" }
    end,
    desc = "New horizontal term",
  },
  {
    mode = "n",
    lhs = "<leader>v",
    rhs = function()
      require("nvchad.term").new { pos = "vsp" }
    end,
    desc = "New vertical term",
  },
  {
    mode = { "n", "t" },
    lhs = "<A-v>",
    rhs = function()
      require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
    end,
    desc = "Toggleable vertical term",
  },
  {
    mode = { "n", "t" },
    lhs = "<A-h>",
    rhs = function()
      require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
    end,
    desc = "Toggleable horizontal term",
  },
  {
    mode = { "n", "t" },
    lhs = "<A-i>",
    rhs = function()
      require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
    end,
    desc = "Toggle floating term",
  },

  -- WhichKey
  { mode = "n", lhs = "<leader>wK", rhs = "<cmd>WhichKey <CR>", desc = "WhichKey all keymaps" },
  {
    mode = "n",
    lhs = "<leader>wk",
    rhs = function()
      vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
    end,
    desc = "WhichKey query lookup",
  },

  -- Menu (Keyboard)
  {
    mode = "n",
    lhs = "<C-t>",
    rhs = function()
      require("menu").open "default"
    end,
    desc = "Open menu",
  },
  -- Select All
  {
    mode = "n",
    lhs = "<C-a>",
    rhs = "ggVG",
    desc = "Select all",
  },
  map("n", "<leader>z", function()
    require("nvchad.themes").open()
  end, { desc = "telescope nvchad themes" }),

  -- Mouse users + nvimtree users
  {
    mode = { "n", "v" },
    lhs = "<RightMouse>",
    rhs = function()
      require("menu.utils").delete_old_menus()
      vim.cmd.exec '"normal! \\<RightMouse>"'
      local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
      local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
      require("menu").open(options, { mouse = true })
    end,
    desc = "Context menu",
  },
}

for _, m in ipairs(editor_mappings) do
  local mode = m.mode or "n"
  local lhs = m.lhs
  local rhs = m.rhs
  local opts = {}
  for k, v in pairs(m) do
    if k ~= "mode" and k ~= "lhs" and k ~= "rhs" then
      opts[k] = v
    end
  end
  map(mode, lhs, rhs, opts)
end
