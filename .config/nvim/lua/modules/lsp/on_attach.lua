local on_attach = {}
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function lsp_highlight_document(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = function()
                vim.lsp.buf.clear_references()
            end,
            buffer = bufnr,
        })

        vim.api.nvim_set_hl(0, "LspReferenceText", { nocombine = true, reverse = false, underline = true })
        vim.api.nvim_set_hl(0, "LspReferenceRead", { nocombine = true, reverse = false, underline = true })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { nocombine = true, reverse = false, underline = true })
    end

    augroup("_lsp", {})
    -- Open float when there are diagnostics
    cmd({ "CursorHold" }, {
        desc = "Open float when there is diagnostics",
        group = "_lsp",
        callback = vim.diagnostic.open_float,
    })
end

function on_attach.setup(client, bufnr)
    lsp_highlight_document(client, bufnr)
end

return on_attach
