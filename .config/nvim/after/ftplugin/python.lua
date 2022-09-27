local options = {
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smarttab = true,
    -- colorcolumn = 90, -- Delimit text blocks to N columns
    conceallevel = 2,
}

for k, v in pairs(options) do
    vim.o[k] = v
end
