local present, bufferline = pcall(require, "bufferline")
if not present then
    return
end

local default = {
    colors = require("core.utils").get(),
}

vim.cmd [[
 function! Quit_vim(a,b,c,d)
     wqa
 endfunction
]]

-- Code from NvChad
bufferline.setup {
    options = {
        hover = {
            enabled = true,
            delay = 0,
            reveal = { "close" },
        },
        numbers = "none",
        themable = true,
        close_command = "bdelete! %d",
        right_mouse_command = "sbuffer %d",
        middle_mouse_command = "vertical sbuffer %d",
        indicator = {
            icon = "▎",
            style = "icon",
        },
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        view = "multiwindow",
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --     return "(" .. count .. ")"
        -- end,
        offsets = { { filetype = "NvimTree", text = "" } },
        separator_style = "thin",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        custom_filter = function(buf_number)
            -- Func to filter out our managed/persistent split terms
            local present_type, type = pcall(function()
                return vim.api.nvim_buf_get_var(buf_number, "term_type")
            end)

            if present_type then
                if type == "vert" then
                    return false
                elseif type == "hori" then
                    return false
                end
                return true
            end

            return true
        end,

        custom_areas = {
            right = function()
                -- Have an icon that u can click to exit vim
                return {
                    { text = "%@Quit_vim@  %X" },
                }
            end,
        },
    },
    highlights = {
        background = {
            fg = default.colors.grey_fg,
            bg = default.colors.black2,
        },

        -- buffers
        -- buffer_selected = {
        --     fg = default.colors.white,
        --     bg = default.colors.black,
        --     gui = "bold,italic",
        -- },
        -- buffer_visible = {
        --     fg = default.colors.light_grey,
        --     bg = default.colors.black2,
        --     gui = "bold,italic",
        -- },
        -- duplicate_selected = {
        --     fg = default.colors.white,
        --     -- bg = default.colors.black,
        --     bg = default.colors.grey,
        --     gui = "bold,italic",
        -- },
        -- duplicate_visible = {
        --     fg = default.colors.white,
        --     bg = default.colors.black2,
        --     gui = "bold,italic",
        -- },

        -- for diagnostics = "nvim_lsp"
        error = {
            fg = default.colors.light_grey,
            bg = default.colors.black2,
        },
        error_diagnostic = {
            fg = default.colors.light_grey,
            bg = default.colors.black2,
        },

        -- close buttons
        close_button = {
            fg = default.colors.light_grey,
            bg = default.colors.black2,
        },
        close_button_visible = {
            fg = default.colors.light_grey,
            bg = default.colors.black2,
        },
        close_button_selected = {
            fg = default.colors.red,
            bg = default.colors.black,
        },
        -- fill = {
        --     fg = default.colors.grey_fg,
        --     bg = "NONE",
        -- },
        indicator_selected = {
            fg = default.colors.black,
            bg = default.colors.black,
        },

        -- modified
        modified = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        modified_visible = {
            fg = default.colors.red,
            bg = default.colors.black2,
        },
        modified_selected = {
            fg = default.colors.green,
            bg = default.colors.black,
        },

        -- separators
        separator = {
            fg = default.colors.black2,
            bg = default.colors.black2,
        },
        separator_visible = {
            fg = default.colors.black2,
            bg = default.colors.black2,
        },
        separator_selected = {
            fg = default.colors.black2,
            bg = default.colors.black2,
        },

        -- tabs
        tab = {
            fg = default.colors.light_grey,
            bg = default.colors.one_bg3,
        },
        tab_selected = {
            fg = default.colors.black2,
            bg = default.colors.nord_blue,
        },
        tab_close = {
            fg = default.colors.red,
            bg = default.colors.black,
        },
    },
}
