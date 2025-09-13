return { 
{
  "neovim/nvim-lspconfig",
  event = "User FilePost",
  config = function()
    require("configs.lspconfig").defaults()
  end,
},

{
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  config = function(_, opts)
    require("luasnip").config.set_config(opts)
    require "configs.luasnip"
  end,
},

{
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "adibhanna/laravel.nvim",
    "onsails/lspkind.nvim",
    "zbirenbaum/copilot-cmp",
    "https://codeberg.org/FelipeLema/cmp-async-path.git",
    -- luasnip is required for snippet expansion
    "L3MON4D3/LuaSnip",
  },
  opts = function()
    return require "configs.cmp"
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)
    -- Integrasi nvim-autopairs dengan cmp
    local has_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
    if has_autopairs then
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
},

{ "rafamadriz/friendly-snippets", lazy = true },

{
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<CR>",
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<C-\\>",
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<C-CR>",
          },
        },
      })

      -- Integrasi Copilot ke nvim-cmp
      require("copilot_cmp").setup()
    end,
  },

{
  "zbirenbaum/copilot-cmp",
  dependencies = { "copilot.lua" },
  config = function()
    require("copilot_cmp").setup()
  end,
},

{
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    bind = true,
    handler_opts = { border = "rounded" },
    floating_window = true,
    hint_enable = true,
    hint_prefix = "🐼 ",
  },
},

{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "vim" },
    fast_wrap = {},
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    -- Integrasi dengan cmp sudah diatur di atas pada nvim-cmp
  end,
},
}
