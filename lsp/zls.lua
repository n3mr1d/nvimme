local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
    cmd = { "zls" },
    filetypes = { "zig", "zir" },
    root_markers = { "zls.json", "build.zig", ".git" },
 
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
),}
