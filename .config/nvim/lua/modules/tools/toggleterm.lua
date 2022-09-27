local present, toggleterm = pcall(require, "toggleterm")
if not present then
    return
end

toggleterm.setup {
    size = 16,
    open_mapping = [[<c-b>]],
    shade_filetypes = {},
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    float_opts = {
        -- border = "shadow",
        border = {
            "╭",
            "─",
            "╮",
            "│",
            "╯",
            "─",
            "╰",
            "│",
        },
        winblend = 0,
        highlights = {
            border = "FloatBorder",
            background = "NormalFloat",
        },
    },
}
