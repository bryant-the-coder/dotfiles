local null_ls = require "null-ls"
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local utils = require "core.utils"

null_ls.setup {
    debug = false,
    sources = {
        formatting.prettier.with {},
        formatting.stylua,
        formatting.rustfmt,
        formatting.clang_format,
        formatting.black.with {
            extra_args = function(_)
                return {
                    "--fast",
                    "--quiet",
                    "--target-version",
                    "py310",
                    "-l",
                    vim.opt_local.colorcolumn:get()[1] or "88",
                }
            end,
        },
        diagnostics.flake8.with {
            extra_args = function(_)
                return { "--max-line-lenth", vim.opt_local.colorcolumn:get()[1] or "88" }
            end,
        },
        -- formatting.yapf,
    },

    -- Format on save (laggy)
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end,
}
