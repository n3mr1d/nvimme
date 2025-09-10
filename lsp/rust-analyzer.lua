local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
    cmd = { "rust-analyzer" },
    root_markers = { "Cargo.lock" },
    filetypes = { "rust" },
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            diagnostics = {
                enable = true,
            },
        },
    },

capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_capabilities,
    {
        fileOperations = {
            didRename = true,
            willRename = true,
        },
    }
),
}
