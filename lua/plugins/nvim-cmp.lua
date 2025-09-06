return {
  "hrsh7th/nvim-cmp",
  opts = {
    sources = {
      { name = "copilot", group_index = 2, priority = 100 },
      -- nvim-lsp tetap di sini
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
  },
}
