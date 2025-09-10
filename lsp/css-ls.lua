local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
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
