-- Taken from coffee

local function clang_format()
    return {
        exe = "clang-format",
        args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
        stdin = true,
        cwd = vim.fn.expand "%:p:h",
    }
end

local function stylua()
    local util = require "formatter.util"
    return {
        exe = "stylua",
        args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
        },
        stdin = true,
    }
end

local function yapf()
    return { exe = "yapf", args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) }, stdin = true }
end

local function isort()
    return { exe = "isort", args = { "-" }, stdin = false }
end

local function gofmt()
    return { exe = "gofmt", args = { "-w" }, stdin = false }
end

local function prettier()
    return {
        exe = "prettier",
        args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
        stdin = true,
    }
end

local function rustfmt()
    return { exe = "rustfmt", args = { "--emit=stdout" }, stdin = true }
end

local function google_java_format()
    return { exe = "google-java-format", args = { vim.api.nvim_buf_get_name(0) }, stdin = true }
end

local formatter = require "formatter"
formatter.setup {
    filetype = {
        c = { clang_format },
        cpp = { clang_format },
        css = { prettier },
        go = { gofmt },
        html = { prettier },
        java = { google_java_format },
        javascript = { prettier },
        lua = { stylua },
        python = { yapf, isort },
        rust = { rustfmt },
    },
}
