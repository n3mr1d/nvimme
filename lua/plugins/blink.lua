return {
  -- Snippet engine
  { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" }, build = "make install_jsregexp" },

  -- nvim-cmp core
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP source
      "hrsh7th/cmp-buffer",       -- buffer source
      "hrsh7th/cmp-path",         -- path completion
      "hrsh7th/cmp-cmdline",      -- cmdline completion
      "saadparwaiz1/cmp_luasnip", -- snippets
      {
        "supermaven-inc/supermaven-nvim", -- AI completion
        opts = {
          disable_inline_completion = true, -- karena kita integrasi lewat cmp
          disable_keymaps = true,
        },
      },
      {
        "Exafunction/codeium.vim", -- alternatif AI completion (gratis)
        enabled = false,           -- bisa switch ke true kalau mau coba
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "supermaven" }, -- AI completions masuk ke cmp
          -- { name = "codeium" }, -- kalau pakai Codeium
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      -- Cmdline setup (opsional)
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
}

