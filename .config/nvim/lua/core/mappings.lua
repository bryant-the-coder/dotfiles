--[[ map("n", "gcc", function() ]]
---@param lhs string Keymaps
---@param rhs string Command
---@param opts string Options
-- local function nimap(lhs, rhs, opts)
-- local default_options = { noremap = true, silent = true }
-- if opts then
--     default_options = vim.tbl_extend("force", default_options, opts)
-- end
-- vim.keymap.set({ "n", "i" }, lhs, rhs, default_options)
-- end

-- local nimap = require("core.utils").normal_insert()

local map = vim.keymap.set
vim.api.nvim_set_keymap(
    "v",
    "<Leader>re",
    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
    { noremap = true, silent = true, expr = false }
)

map("n", "<leader>ta", [[<cmd>put! =repeat(nr2char(10), v:count1)<cr>'[]])

-----------------------------------
--           BASIC               --
-----------------------------------
-- Quitting
map("n", "<C-q>", "<cmd>q<CR>")

-- Buffer
map("n", "<leader>dd", "<cmd>bdelete<CR>")

-- Pasting stuff
map("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>')

-- Folding
map("n", "<space>", "za")

-- Don't yank text upon delete (good mapping btw)
map("v", "d", '"_d"')

-- Don't yank text on cut
map("n", "x", '"_x')

-- ESC to clear all highlights
map({ "n", "i", "v" }, "<ESC>", "<cmd>noh<CR>")
-- map({ "n", "v" }, "<CR>", [[{-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]], { silent = true, expr = true })

-- Running and exec files
map("n", "<leader>ex", "<cmd>call bryant#save_and_exec()<CR>")

-- Saving the traditional way
map({ "n", "i" }, "<C-s>", "<cmd>w<CR>")
-- nimap("<C-s>", "<cmd>w<CR>")
map("n", "<leader>sf", "<cmd>source % <CR>")

--  j = gj
-- k = gk
map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")

-- Indenting
map("v", ">", ">gv")
map("v", "<", "<gv")

-- ESC key
map({ "i", "v" }, "jk", "<Esc>")
map({ "i", "v" }, "JK", "<ESC>")

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
--[[ map({ "n", "v" }, "j", "jzzzv")
map({ "n", "v" }, "k", "kzzzv") ]]

-- Disable arrow keys
map({ "n", "v" }, "<Up>", "<nop>")
map({ "n", "v" }, "<Down>", "<nop>")
map({ "n", "v" }, "<Left>", "<nop>")
map({ "n", "v" }, "<Right>", "<nop>")

-- Terminal ESC key
-- map("n", "<leader>vs", "<cmd>90 vsp | :term<CR>")
map("n", "<leader>v", "<cmd>vsp | :term<CR>")
map("n", "<leader>h", "<cmd>17 sp | :term<CR>")
map("t", "jk", "<C-\\><C-n>")
map("t", "<Esc>", "<C-\\><C-n> <cmd>bd!<CR>")

-- Resizing windows
map("n", "<A-up>", "<C-w>+")
map("n", "<A-down>", "<C-w>-")
map("n", "<A-left>", "<C-w>>")
map("n", "<A-right>", "<C-w><")

-- Window Navigation
map("", "H", "<C-w>h")
map("", "K", "<C-w>k")
map("", "J", "<C-w>j")
map("", "L", "<C-w>l")

-- Buffer navigation
map("n", "<Tab>", "<cmd>bnext<CR>")
map("n", "<S-Tab>", "<cmd>bprevious<CR>")

-- Moving lines up & down (complicated)
map("n", "<C-down>", "<cmd>m .+1<CR>==")
map("n", "<C-up>", "<cmd>m .-2<CR>==")
map("v", "<C-down>", "<cmd>m '>+1<CR>gv=gv")
map("v", "<C-up>", "<cmd>m '<-2<CR>gv=gv")

-- Insert a new line
-- Code from max
map("n", "<A-CR>", "O<ESC>", { desc = "Empty line above" })
map("n", "<CR>", "o<ESC>", { desc = "Empty line below" })
map("n", "<leader>lb", "i<CR><ESC>", { desc = "Line break at cursor" })
map("n", "<leader>il", "i <ESC>l", { desc = "Space before" })
map("n", "<leader>ih", "a <ESC>h", { desc = "Space after" })
map("n", "<F10>", function()
    if vim.o.conceallevel > 0 then
        vim.o.conceallevel = 0
    else
        vim.o.conceallevel = 2
    end
end)

-- Wrting a file without a name
-- This will ask for the filename then write it
-- Credit: https://www.reddit.com/r/neovim/comments/xazxxe/comment/inwtkis/?utm_source=share&utm_medium=web2x&context=3
map("n", "<leader>w", function()
    local ok, res = pcall(vim.cmd, "write")
    if ok then
        return
    elseif res:match "^Vim%(write%):E32:" then
        ok, res = pcall(vim.fn.input, "File name: ")
        if ok and res and res ~= "" then
            vim.cmd("write " .. res)
        end
    else
        vim.api.nvim_err_writeln(res)
    end
end)

-----------------------------------
--           Utils               --
-----------------------------------
map("n", "<leader>sb", function()
    require("core.utils").swap_boolean()
end)

map("n", "<A-r>", function()
    require("core.utils").rename()
end)

map("n", "l", function()
    require("core.utils").l_motion()
end)
map("n", "h", function()
    require("core.utils").h_motion()
end)
map("n", "<leader>,", function()
    require("core.utils").insert_comma()
end)
map("n", "<leader>;", function()
    require("core.utils").insert_semicolon()
end)

-----------------------------------
--           Plugins             --
-----------------------------------
-- Nvim-tree
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>")

-- Noerg
map("n", "<leader>jt", "<cmd>Neorg journal today<CR>")

-- Neo-tree
map("n", "<leader>nr", "<cmd>NeoTreeFocusToggle<CR>")
map("n", "<leader>nf", "<cmd>Neotree float<CR>")

-- Zen-mode
map("n", "<leader>zm", "<cmd>ZenMode<CR>")

-- Trouble
map("n", "<leader>tt", "<cmd>Trouble<CR>")

-- Neogen
map("n", "<leader>ng", "<cmd>Neogen<CR>")

-- TSPlayground
map("n", "<leader>tp", "<cmd>TSPlaygroundToggle<CR>")
map("i", "<leader>tp", "<cmd>TSPlaygroundToggle<CR>")

-- Cybu
map("n", "sk", "<Plug>(CybuPrev)")
map("n", "sj", "<Plug>(CybuNext)")

-- Lsp-Inlayhints
map("n", "<space>lh", function()
    require("lsp-inlayhints").toggle()
end)

-- Packer
map("n", "<leader>pi", "<cmd>PackerInstall<CR>")
map("n", "<leader>pu", "<cmd>PackerUpdate<CR>")
map("n", "<leader>pc", "<cmd>PackerClean<CR>")
map("n", "<leader>ps", "<cmd>PackerSync<CR>")
map("n", "<leader>pp", "<cmd>PackerStatus<CR>")

-- LSP
map("n", "<leader>lr", function()
    require("core.utils").open()
end)
map("n", "<leader>ld", vim.lsp.buf.definition)
map("n", "<leader>lt", vim.lsp.buf.type_definition)
map("n", "<leader>lh", vim.lsp.buf.signature_help)
map("n", "<leader>qf", vim.diagnostic.setqflist)
map("n", "<C-a>", vim.lsp.buf.references)
-- map("n", "<C-k>", vim.diagnostic.goto_prev)
-- map("n", "<C-j>", vim.diagnostic.goto_next)
map("n", "<leader>lbh", function()
    require("core.utils").show_documentation()
end, { desc = "Show the documentation in a floating window" })

map("n", "<C-k>", function()
    vim.diagnostic.goto_prev { border = "rounded" }
end)
map("n", "<C-j>", function()
    vim.diagnostic.goto_next { border = "rounded" }
end)

-- Harpooon
map("n", "<A-p>", function()
    require("harpoon.ui").toggle_quick_menu()
end)
map("n", "<A-=>", function()
    require("harpoon.mark").add_file()
end)
map("n", "<A-1>", function()
    require("harpoon.ui").nav_file(1)
end)
map("n", "<A-2>", function()
    require("harpoon.ui").nav_file(2)
end)
map("n", "<A-3>", function()
    require("harpoon.ui").nav_file(3)
end)
map("n", "<A-4>", function()
    require("harpoon.ui").nav_file(4)
end)

-- Telescope
map("n", "<leader>ff", function()
    require("modules.files.telescope").find_files()
    -- require("telescope.builtin").find_files()
end)
map("n", "<leader>fw", function()
    require("modules.files.telescope").live_grep()
    -- require("telescope.builtin").live_grep()
end)
map("n", "<leader>fd", function()
    require("modules.files.telescope").diag()
    -- require("telescope.builtin").diagnostics()
end)
map("n", "<C-p>", function()
    require("modules.files.telescope").buffers()
    -- require("telescope.builtin").buffers()
end)
map("n", "<leader>fc", function()
    require("telescope.builtin").colorscheme()
end)
map("n", "<leader>fo", function()
    require("telescope.builtin").oldfiles()
end)
map("n", "<leader>fk", function()
    require("telescope.builtin").keymaps()
end)
map("n", "<leader>fm", function()
    require("telescope.builtin").current_buffer_fuzzy_find()
end)
map("n", "<leader>ft", function()
    require("telescope.builtin").treesitter()
end)
map("n", "<leader>fb", "<cmd>Telescope file_browser<CR>")
map("n", "<leader>ft", function()
    require("modules.files.telescope").harpoon()
end)
