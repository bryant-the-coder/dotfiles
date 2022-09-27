local utils = {}
local cmd = vim.cmd
local api = vim.api

--- Define bg color
---@param group string
---@param col string
utils.bg = function(group, col)
    cmd("hi " .. group .. " guibg=" .. col)
end

--- Define fg color
---@param gruop string
---@param col string
utils.fg = function(gruop, col)
    cmd("hi " .. gruop .. " guifg=" .. col)
end

--- Define fg & bg color
---@param group string
---@param fgcol string
---@param bgcol string
utils.fg_bg = function(group, fgcol, bgcol)
    cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

--- Getting color from base16
utils.get = function()
    local theme = _G.theme
    return require("hl_themes." .. theme)
end

utils.get_base = function()
    local theme = _G.theme
    return require("themes." .. theme .. "-base16")
end

--- Swap between booleans with ease
utils.swap_boolean = function()
    local c = api.nvim_get_current_line()
    local subs = c:match "true" and c:gsub("true", "false") or c:gsub("false", "true")
    api.nvim_set_current_line(subs)
end

--- Rename a variable (simple)
---@return string
utils.rename = function()
    -- local border = {
    --     { "┏", "FloatBorder" },
    --     { "━", "FloatBorder" },
    --     { "┓", "FloatBorder" },
    --     { "┃", "FloatBorder" },
    --     { "┛", "FloatBorder" },
    --     { "━", "FloatBorder" },
    --     { "┗", "FloatBorder" },
    --     { "┃", "FloatBorder" },
    -- }

    -- local border = {
    -- { "╔", "FloatBorder" },
    -- { "═", "FloatBorder" },
    -- { "╗", "FloatBorder" },
    -- { "║", "FloatBorder" },
    -- { "╝", "FloatBorder" },
    -- { "═", "FloatBorder" },
    -- { "╚", "FloatBorder" },
    -- { "║", "FloatBorder" },
    -- }

    -- local border = {
    --     { "╭", "FloatBorder" },
    --     { "─", "FloatBorder" },
    --     { "╮", "FloatBorder" },
    --     { "│", "FloatBorder" },
    --     { "╯", "FloatBorder" },
    --     { "─", "FloatBorder" },
    --     { "╰", "FloatBorder" },
    --     { "│", "FloatBorder" },
    -- }

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

    local function post(rename_old)
        vim.cmd "stopinsert!"
        local rename_new = api.nvim_get_current_line()
        vim.schedule(function()
            api.nvim_win_close(0, true)
            vim.lsp.buf.rename(vim.trim(rename_new))
        end)
        -- Use notify.nvim, logs notification as warn, title as Variable Rename
        vim.notify(rename_old .. "  " .. rename_new, "warn", { title = "Variable Rename", icon = "ﰇ" })
    end

    local rename_old = vim.fn.expand "<cword>"
    local created_buffer = api.nvim_create_buf(false, true)
    api.nvim_open_win(created_buffer, true, {
        relative = "cursor",
        style = "minimal",
        border = border,
        row = 1,
        col = 0,
        width = 30,
        height = 1,
    })
    vim.cmd "startinsert"

    vim.keymap.set("i", "<ESC>", function()
        vim.cmd "q"
        vim.cmd "stopinsert"
    end, { buffer = created_buffer })

    vim.keymap.set("i", "<CR>", function()
        return post(rename_old)
    end, { buffer = created_buffer })
end

utils.l_motion = function()
    local cursorPosition = api.nvim_win_get_cursor(0)
    vim.cmd "normal ^"
    local firstChar = api.nvim_win_get_cursor(0)

    if cursorPosition[2] < firstChar[2] then
        vim.cmd "normal ^"
    else
        api.nvim_win_set_cursor(0, cursorPosition)
        vim.cmd "normal! l"
    end
end

utils.h_motion = function()
    local cursorPosition = api.nvim_win_get_cursor(0)
    vim.cmd "normal ^"
    local firstChar = api.nvim_win_get_cursor(0)

    if cursorPosition[2] <= firstChar[2] then
        vim.cmd "normal 0"
    else
        api.nvim_win_set_cursor(0, cursorPosition)
        vim.cmd "normal! h"
    end
end

utils.border = function()
    return {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
    }
end

--- Inserts a "," add the end of line
utils.insert_comma = function()
    local cursor = api.nvim_win_get_cursor(0)
    -- append ,
    vim.cmd [[normal A,]]
    -- restore cursor position
    api.nvim_win_set_cursor(0, cursor)
end

--- Inserts a ";" add the end of line
utils.insert_semicolon = function()
    -- save cursor position
    local cursor = api.nvim_win_get_cursor(0)
    -- append ,
    vim.cmd [[normal A;]]
    -- restore cursor position
    api.nvim_win_set_cursor(0, cursor)
end

--- Checking for neovim version
---@param version string version number
---@return boolean has_version
utils.has_version = function(version)
    return vim.fn.has("nvim-" .. version) > 0
end

utils.open = function()
    local currName = vim.fn.expand "<cword>" .. " "

    local win = require("plenary.popup").create("  ", {
        title = currName,
        style = "minimal",
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        relative = "cursor",
        borderhighlight = "RenamerBorder",
        titlehighlight = "RenamerTitle",
        focusable = true,
        width = 25,
        height = 1,
        line = "cursor+2",
        col = "cursor-1",
    })

    local map_opts = { noremap = true, silent = true }

    vim.cmd "normal w"
    vim.cmd "startinsert"

    api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)
    api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", map_opts)

    api.nvim_buf_set_keymap(
        0,
        "i",
        "<CR>",
        "<cmd>stopinsert | lua require'core.utils'.apply(" .. currName .. "," .. win .. ")<CR>",
        map_opts
    )

    api.nvim_buf_set_keymap(
        0,
        "n",
        "<CR>",
        "<cmd>stopinsert | lua require'core.utils'.apply(" .. currName .. "," .. win .. ")<CR>",
        map_opts
    )
end

utils.apply = function(curr, win)
    local newName = vim.trim(vim.fn.getline ".")
    api.nvim_win_close(win, true)

    if #newName > 0 and newName ~= curr then
        local params = vim.lsp.util.make_position_params()
        params.newName = newName

        vim.lsp.buf_request(0, "textDocument/rename", params)
        vim.notify(newName .. " is set", "warn", { title = "Variable Rename", icon = "凜" })
    end
end

-- Show doumentation in a fancy and easy window
utils.show_documentation = function()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand "<cword>")
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand "<cword>")
    elseif vim.fn.expand "%:t" == "Cargo.toml" then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end

-- Check if its empty or not
utils.is_empty = function(s)
    return s == nil or s == ""
end

--- check if the buffer return smth or not
utils.get_buf_option = function(opt)
    local status_ok, buf_option = pcall(api.nvim_buf_get_option, 0, opt)
    if not status_ok then
        return nil
    else
        return buf_option
    end
end

return utils
