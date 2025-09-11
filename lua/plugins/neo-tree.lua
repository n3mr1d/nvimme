return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      sort_case_insensitive = false,
      default_component_configs = {
        container = { enable_character_fade = true },
        indent = { padding = 0, indent_size = 2 },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "ﰊ",
          default = "",
        },
        git_status = {
          symbols = {
            added = "✚",
            modified = "",
            removed = "✖",
            renamed = "➜",
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✔",
          },
        },
      },
      window = {
        position = "left",
        width = 35,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["v"] = "open_vsplit",

          -- Create file relative path
          ["a"] = function(state)
            local node = state.tree:get_node()
            if not node then
              return
            end

            local folder
            if node.type == "directory" then
              folder = node.path
            elseif node.parent then
              folder = node.parent.path
            else
              folder = vim.loop.cwd()
            end

            local name = vim.fn.input("New file name: ")
            if name == "" then
              return
            end

            local path = folder .. "/" .. name
            vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
            vim.cmd("edit " .. vim.fn.fnameescape(path))

            local neo_tree = require("neo-tree")
            if neo_tree and neo_tree.sources and neo_tree.sources.filesystem then
              neo_tree.sources.filesystem.refresh()
            end
          end,

          -- Create folder relative path
          ["A"] = function(state)
            local node = state.tree:get_node()
            if not node then
              return
            end

            local folder
            if node.type == "directory" then
              folder = node.path
            elseif node.parent then
              folder = node.parent.path
            else
              folder = vim.loop.cwd()
            end

            local name = vim.fn.input("New folder name: ")
            if name == "" then
              return
            end

            local path = folder .. "/" .. name
            vim.fn.mkdir(path, "p")

            local neo_tree = require("neo-tree")
            if neo_tree and neo_tree.sources and neo_tree.sources.filesystem then
              neo_tree.sources.filesystem.refresh()
            end
          end,
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true, -- sebelumnya: follow_current_file = true
          leave_dirs_open = false, -- opsional, default false
        },
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { ".git", "node_modules", ".cache" },
        },
      },
      git_status = { window = { position = "float" } },
      buffers = {
        follow_current_file = {
          enabled = true, -- sebelumnya: follow_current_file = true
        },
        group_empty_dirs = true,
        show_unloaded = true,
      },
    },
    config = function(_, opts)
      local neo_tree = require("neo-tree")
      neo_tree.setup(opts)

      -- 🔗 Snacks Rename Integration
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end,
  },
}
