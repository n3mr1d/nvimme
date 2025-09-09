return {
  {
    "gbprod/phpactor.nvim",
    ft = "php",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function(_, opts)
      require("phpactor").setup(opts)
    end,
  },
}
