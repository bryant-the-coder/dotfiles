local default_keymaps = {
    { "n", "s", "<Plug>Lightspeed_omni_s" },
    { "x", "s", "<Plug>Lightspeed_omni_s" },
    { "o", "s", "<Plug>Lightspeed_omni_s" },
}
for _, m in ipairs(default_keymaps) do
    vim.keymap.set(m[1], m[2], m[3], { noremap = true, silent = true })
end
