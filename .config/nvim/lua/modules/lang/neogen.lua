local present, neogen = pcall(require, "neogen")
if not present then
    return
end

neogen.setup {
    snippet_engine = "luasnip",
    enabled = true,
    languages = {
        lua = {
            template = {
                annotation_convention = "ldoc",
            },
        },
        python = {
            template = {
                annotation_convention = "numpydoc",
            },
        },
    },
}
