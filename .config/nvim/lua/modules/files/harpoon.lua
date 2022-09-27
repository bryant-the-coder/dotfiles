local present, harpoon = pcall(require, "harpoon")
if not present then
    return
end

harpoon.setup {
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { "harpoon", "package.lock.json" },
    },
}
