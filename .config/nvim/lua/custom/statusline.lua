local fn = vim.fn
local api = vim.api
local fmt = string.format
local space = " "

local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local statusline = {}

-- Making the modes name UPPERCASE
local function mode()
    local current_mode = api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

-- Change the color base on the modes
--- Mode colors
---@return any modes | colors
local function update_mode_colors()
    local current_mode = api.nvim_get_mode().mode
    local mode_color = "%#StatusLineAccent#"
    if current_mode == "n" then
        mode_color = "%#StatusNormal#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#StatusInsert#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#StatusVisual#"
    elseif current_mode == "R" then
        mode_color = "%#StatusReplace#"
    elseif current_mode == "c" then
        mode_color = "%#StatusCommand#"
    elseif current_mode == "t" then
        mode_color = "%#StatusTerminal#"
    end
    return mode_color
end

-- Filename
local function file()
    local icon = ""
    local filename = fn.pathshorten(fn.expand "%:t", ":r")
    -- local filename = vim.fn.pathshorten(vim.fn.fnamemodify(self.filename, ":."))
    local extension = fn.expand "%:e"

    if filename == "" then
        icon = icon .. "  Empty "
    else
        filename = " " .. filename .. " "
    end

    --[[ if vim.bo.modified then
        return " " .. filename
    end ]]

    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if not devicons_present then
        return " "
    end

    local ft_icon = devicons.get_icon(filename, extension)
    icon = (ft_icon ~= nil and " " .. ft_icon) or icon

    return "%#Filename#" .. icon .. filename
end

local function work_dir()
    local cwd = vim.fn.getcwd(0)
    cwd = vim.fn.fnamemodify(cwd, ":~")
    cwd = vim.fn.pathshorten(cwd)
    local trail = cwd:sub(-1) == "/" and "" or "/"
    return " " .. cwd .. trail
end

-- Git
local git = function()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
        return ""
    end

    return "%#Branch#  " .. git_info.head .. " " .. "%#Statusline#"
end

local git_info = function()
    if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
        return ""
    end

    local git_status = vim.b.gitsigns_status_dict

    local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
    local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
    local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
    local git_info = added .. changed .. removed

    return "%#GitInfo#" .. git_info .. "%#Statusline#"
end

-- LSP
local function get_diagnostic(prefix, severity)
    local count
    if vim.fn.has "nvim-0.6" == 0 then
        count = vim.lsp.diagnostic.get_count(0, severity)
    else
        local severities = {
            ["Warning"] = vim.diagnostic.severity.WARN,
            ["Error"] = vim.diagnostic.severity.ERROR,
            ["Info"] = vim.diagnostic.severity.INFO,
            ["Hint"] = vim.diagnostic.severity.HINT,
        }
        count = #vim.diagnostic.get(0, { severity = severities[severity] })
    end
    return fmt("%s%d ", prefix, count)
end

local function get_error()
    return "%#Error#" .. get_diagnostic(" ", "Error")
end

local function get_warning()
    return "%#Warning#" .. get_diagnostic(" ", "Warning")
end

local function get_hint()
    return "%#Hint#" .. get_diagnostic(" ", "Hint")
end

local function get_info()
    return "%#Info#" .. get_diagnostic(" ", "Info")
end

-- Clock
local function clock()
    return "%#Clock#" .. " 什 " .. os.date "%H:%M "
end

-- Treesitter status
local function ts_status()
    local ts = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
    -- If ts is available, return ""
    -- If ts isnt available, return "滑 unavailable"
    return (ts and next(ts)) and "" or " 滑 unavailable "
end

local function coords()
    return "%#Coords#" .. " %4(%l%):%2c"
end

local function progress_bar()
    local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇" }
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#sbar - 1)) + 1
    return sbar[i]
end

local function word_counter()
    local wc = vim.api.nvim_eval "wordcount()"
    if wc["visual_words"] then
        return wc["visual_words"]
    else
        return wc["words"]
    end
end

-- Shows the number of search
-- Shows the word that you search
--- @return string
local function search_count()
    local res = vim.fn.searchcount { recomput = 1, maxcount = 1000 }

    if res.total ~= nil and res.total > 0 then
        return string.format(
            " 爵 %s/%d %s ",
            -- ' %s/%d %s ',
            res.current,
            res.total,
            vim.fn.getreg "/"
        )
    else
        return ""
    end
end

statusline.run = function()
    return table.concat {
        "%#Statusline#",
        update_mode_colors(), -- Update mode colors
        -- work_dir(),
        mode(), -- Show mode
        "%#Normal#",
        git(),
        -- git_info(),
        -- "%#Statusline#",
        ts_status(),
        "%#SearchCount#",
        search_count(),
        "%#Statusline#",

        "%=",
        file(), -- Show filename
        "%=",

        space,
        get_error(),
        get_warning(),
        get_hint(),
        get_info(),

        -- coords(),
        clock(),
        -- progress_bar(),
    }
end

return statusline
