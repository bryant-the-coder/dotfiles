local status_ok, dim = pcall(require, "neodim")
if not status_ok then
    return
end

dim.setup {
    alpha = 0.5,
    blend_color = "#000000",
    update_in_insert = {
        enable = true,
        delay = 100,
    },
    hide = {
        virtual_text = true,
        signs = true,
        underline = true,
    },
}
