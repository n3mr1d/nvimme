local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = {
        "html",
        "blade",
        "javascriptreact",
        "typescriptreact",
        "svelte",
    },
    root_markers = { "index.html", ".git" },
    init_options = { provideFormatter = true },
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
