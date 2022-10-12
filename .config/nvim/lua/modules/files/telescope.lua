local present, telescope = pcall(require, "telescope")
if not present then
    return
end

vim.cmd [[
    PackerLoad telescope-fzf-native.nvim
    PackerLoad telescope-file-browser.nvim
]]

local actions = require "telescope.actions"
local theme = require "telescope.themes"
local previewers_utils = require "telescope.previewers.utils"

telescope.setup {
    defaults = {
        layout_config = {
            width = 0.75,
            prompt_position = "top",
            preview_cutoff = 120,
            horizontal = { mirror = false },
            vertical = { mirror = false },
        },

        -- Transparency settings
        -- winblend = 20,

        find_command = { "rg", "-L", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        prompt_prefix = "  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        file_ignore_patterns = {
            "__pycache__",
            "node_modules",
            ".jpg",
            ".jpeg",
            ".png",
            ".ico",
            ".add",
        },
        path_display = { "shorten" }, -- see :h telescope.defaults.path_display
        preview = {
            filesize_hook = function(filepath, bufnr, opts)
                -- If the file is very big only print the head of the it
                -- To prevent lag
                local cmd = { "head", "-c", 1000000, filepath }
                previewers_utils.job_maker(cmd, bufnr, opts)
            end,
        },
        mappings = {
            i = {
                ["<TAB>"] = actions.move_selection_next,
                ["<S-TAB>"] = actions.move_selection_previous,
                ["<esc>"] = actions.close,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },

    pickers = {
        live_grep = {
            preview_title = "~ Location Preview ~ ",
            prompt_title = "~ Find String ~",
            border = true,
            disable_coordinates = true,
            file_ignore_patterns = {
                "vendor/*",
                "node_modules",
                "%.jpg",
                "%.jpeg",
                "%.png",
                "%.svg",
                "%.otf",
                "%.ttf",
            },
        },
        --[[ find_files = {
            prompt_title = "~ Find Files ~",
            preview_title = "~ File Preview ~",
            results_title = "~ Files ~",
        }, ]]
        diagnostics = {
            prompt_title = "~ Diagnostics ~",
            preview_title = "~ Diagnostics Preview ~",
        },
        buffers = {
            -- Anchor = N is to place the prompt in the middle of the screen
            layout_config = { height = 25, width = 90, anchor = "N" },
            previewer = false,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        file_browser = {},
    },
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "file_browser"
require("telescope").load_extension "harpoon"

local custom_telescope = {}

custom_telescope.find_files = function()
    local opts = {
        -- prompt_title = " [ FIND FILES ]",
        prompt_title = "~ Find Files ~",
        preview_title = "~ File Preview ~",
        results_title = "~ Files ~",
        layout_config = {
            prompt_position = "top",
        },
        hidden = false,
    }
    require("telescope.builtin").find_files(opts)
end

custom_telescope.live_grep = function()
    local opts = {
        preview_title = "~ Location Preview ~ ",
        prompt_title = "~ Find String ~",
        border = true,
        disable_coordinates = true,
        file_ignore_patterns = {
            "vendor/*",
            "node_modules",
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.svg",
            "%.otf",
            "%.ttf",
        },
    }
    require("telescope.builtin").live_grep(opts)
end

custom_telescope.diag = function()
    local opts = {
        prompt_title = "~ Diagnostics ~",
        preview_title = "~ Diagnostics Preview ~",
    }
    require("telescope.builtin").diagnostics(opts)
end

custom_telescope.buffers = function()
    local opts = {
        layout_config = {
            height = 25,
            width = 90,
            anchor = "N",
        },
        previewer = false,
    }
    require("telescope.builtin").buffers(opts)
end

custom_telescope.harpoon = function()
    local opts = {
        layout_config = {
            height = 25,
            width = 100,
            -- anchor = "N",
        },
        previewer = false,
        prompt_title = "~ Harpoon ~",
    }
    require("telescope").extensions.harpoon.marks(opts)
end

return custom_telescope
