

return {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php", "blade" },
    root_markers = { "composer.json", ".git" },
    init_options = {
       -- licenceKey = get_intelephense_license(),
    },
}
