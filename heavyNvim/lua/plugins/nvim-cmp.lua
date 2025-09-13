local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("%S") ~= nil
end

return {
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()

      vim.keymap.set({"i", "s"}, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({"i", "s"}, "<C-j>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })
    end,
  },

  { "rafamadriz/friendly-snippets", lazy = true },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  -- Copilot-cmp source
  {
    "zbirenbaum/copilot-cmp",
    after = "copilot.lua",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- LSP signature help
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

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true, ts_config = { lua = { "string", "source" }, javascript = { "string", "template_string" }, java = false }, disable_filetype = { "TelescopePrompt", "vim" } },
  },

  -- lspkind with Codicons / Nerd Font
  {
    "onsails/lspkind.nvim",
    event = "InsertEnter",
    config = function()
      require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      })
    end,
  },

  -- nvim-cmp
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
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      vim.api.nvim_set_hl(0, "CmpGhostText", { fg = "#565f89", italic = true })
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#7c3aed", italic = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82aaff", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82aaff", bold = true })

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },

        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({ border = "rounded", winhighlight = "Normal:CmpDoc" }),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "copilot", priority = 1200 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "nvim_lsp_signature_help", priority = 700 },
          { name = "laravel", priority = 650 },
          { name = "nvim_lua", priority = 500 },
          { name = "buffer", priority = 400, keyword_length = 3 },
          { name = "path", priority = 300 },
        }),

        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            preset = "codicons",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                buffer = "[Buf]",
                path = "[Path]",
                nvim_lua = "[Lua]",
                laravel = "[Laravel]",
                copilot = "[AI]",
                nvim_lsp_signature_help = "[Sig]",
              })[entry.source.name]
              return vim_item
            end,
          }),
        },

        experimental = { ghost_text = { hl_group = "CmpGhostText" } },

        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })

      -- Cmdline
      cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })
      cmp.setup.cmdline(":", { mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }) })

      -- Autopairs integration
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Extra utilities
  { "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = function() require("nvim-surround").setup({}) end },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
}

