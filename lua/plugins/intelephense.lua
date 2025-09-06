return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          filetypes = { "php", "blade", "php_only" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("composer.json", "artisan", ".git")(fname)
              or util.path.dirname(fname)
          end,
          settings = {
            intelephense = {
              files = {
                associations = { "*.php", "*.blade.php" },
                maxSize = 5000000,
              },
              environment = {
                includePaths = { "./vendor" },
              },
			stubs = { "laravel", "laravel-framework" },
            },
          },
        },
        phpactor = {
          filetypes = { "php", "blade", "php_only" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("composer.json", "artisan", ".git")(fname)
              or util.path.dirname(fname)
          end,
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      lspconfig.intelephense.setup(opts.servers.intelephense)
      lspconfig.phpactor.setup(opts.servers.phpactor)

      vim.opt.mouse = "a"
      vim.keymap.set("n", "<C-LeftMouse>", vim.lsp.buf.definition, { noremap = true, silent = true })
    end,
  },
}
