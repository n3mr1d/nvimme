return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
      ---@type conform.setupOpts
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        -- Go
        go = { "goimports", "gofmt" },

        -- Lua
        lua = { "stylua" },

        -- Web technologies
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        blade = { "tlint" },
        -- Python
        python = { "isort", "black" },

        -- PHP/Laravel
        php = { "pint" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Other (system tools)
        rust = { "rustfmt" }, -- comes with Rust installation

        -- Additional file types (uncomment as needed)
        -- markdown = { "markdownlint" },
        -- yaml = { "yamllint" },
        -- toml = { "taplo" },
      },

      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    },
  },
}
