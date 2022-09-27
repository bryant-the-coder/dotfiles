local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
    return
end

local map = vim.keymap.set
local action = require "lspsaga.action"

saga.init_lsp_saga {
    -- Options with default value
    -- "single" | "double" | "rounded" | "bold" | "plus"
    border_style = "rounded",
    --the range of 0 for fully opaque window (disabled) to 100 for fully
    --transparent background. Values between 0-30 are typically most useful.
    saga_winblend = 0,
    -- when cursor in saga window you config these to move
    move_in_saga = { prev = "<C-p>", next = "<C-n>" },
    diagnostic_header = { " ", " ", " ", " " },
    -- show diagnostic source
    show_diagnostic_source = true,
    -- add bracket or something with diagnostic source, just have 2 elements
    diagnostic_source_bracket = {},
    -- preview lines of lsp_finder and definition preview
    max_preview_lines = 30,
    -- use emoji lightbulb in default
    code_action_icon = "💡",
    -- if true can press number to execute the codeaction in codeaction window
    code_action_num_shortcut = true,
    -- same as nvim-lightbulb but async
    code_action_lightbulb = {
        enable = false,
        sign = false,
        enable_in_insert = false,
        sign_priority = 20,
        virtual_text = false,
    },
    -- finder icons
    finder_icons = {
        def = "  ",
        ref = "諭 ",
        link = "  ",
    },
    -- custom finder title winbar function type
    -- param is current word with symbol icon string type
    -- return a winbar format string like `%#CustomFinder#Test%*`
    finder_action_keys = {
        open = "o",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = "q",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>", -- quit can be a table
    },
    code_action_keys = {
        quit = "q",
        exec = "<CR>",
    },
    rename_action_quit = "<Esc>",
    rename_in_select = true,
    definition_preview_icon = "  ",
    -- show symbols in winbar must nightly
    symbol_in_winbar = {
        in_custom = false,
        enable = false,
        separator = " ",
        show_file = true,
        click_support = false,
    },
    -- show outline
    show_outline = {
        win_position = "right",
        --set special filetype win that outline window split.like NvimTree neotree
        -- defx, db_ui
        win_with = "",
        win_width = 30,
        auto_enter = true,
        auto_preview = true,
        virt_text = "┃",
        jump_key = "o",
        -- auto refresh when change buffer
        auto_refresh = true,
    },
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = { metals = { "sbt", "scala" } }
    server_filetype_map = {},
}

--[[ map("n", "<C-j>", require("lspsaga.diagnostic").goto_next)
map("n", "<C-k>", require("lspsaga.diagnostic").goto_prev) ]]
--[[ map("n", "<leader>ld", require("lspsaga.definition").preview_definition)
-- show hover doc and press twice will jumpto hover window
map("n", "<leader>lh", require("lspsaga.signaturehelp").signature_help)
map("n", "<leader>lf", "<cmd>Lspsaga lsp_finder<CR>")

-- scroll down hover doc or scroll in definition preview
map("n", "<C-f>", function()
    action.smart_scroll_with_saga(1)
end, { silent = true })
-- scroll up hover doc
map("n", "<C-b>", function()
    action.smart_scroll_with_saga(-1)
end, { silent = true })

map("n", "<leader>lr", require("lspsaga.rename").lsp_rename)
map("n", "<leader>lo", "<cmd>LSoutlineToggle<CR>") ]]
