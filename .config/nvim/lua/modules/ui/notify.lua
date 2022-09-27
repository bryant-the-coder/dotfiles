-- Most of the setup is taken from akinsho
local notify = require "notify"

local border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" },
}

local default = {
    stages = "fade",
    timeout = 2000,
    max_width = function()
        return math.floor(vim.o.columns * 0.8)
    end,
    max_height = function()
        return math.floor(vim.o.lines * 0.8)
    end,
    icons = {
        ERROR = " ",
        WARN = " ",
        INFO = " ",
        DEBUG = " ",
        TRACE = " ",
    },
    background_colour = "#000000",
    on_open = function(win)
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, { border = border })
        end
    end,
}

vim.opt.termguicolors = true

notify.setup(default)

vim.notify = function(msg, level, opts)
    notify(msg, level, opts)
end

function _G.P(...)
    print(vim.inspect(...))
    return ...
end

vim.notify = require "notify"

-- vim.cmd([[
-- highlight link NotifyERRORBody Normal
-- highlight link NotifyWARNBody Normal
-- highlight link NotifyINFOBody Normal
-- highlight link NotifyDEBUGBody Normal
-- highlight link NotifyTRACEBody Normal
-- ]])

-- This is a command i got from a repo. Will test it out soon
-- vim.api.nvim_command('highlight LightBulbFloatWin ctermfg= ctermbg= guifg= guibg=')
