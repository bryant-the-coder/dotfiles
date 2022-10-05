require "core.disable_builtin"
local utils = require "core.utils"

local g = vim.g
local o = vim.opt

--Cursor & cursorline
-- o.guicursor = "n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
-- o.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor-blinkwait300-blinkon500-blinkoff300,r-cr-o:hor20"
o.cursorline = true
o.cursorlineopt = { "number" } -- Highlighting the number where the cursor is on

-- Mappings
g.mapleader = ","
o.mouse = "a"
o.mousemoveevent = true

-- Theme
o.termguicolors = true

-- Number
o.number = true
o.relativenumber = true
o.signcolumn = "yes:2"
o.scrolloff = 1000 -- Stop scrolling on the number set

-- Splits
o.splitright = true
o.splitbelow = true

-- Command line
o.shortmess:append "I"
o.cmdheight = 1
o.hidden = true
o.history = 300
o.updatetime = 200
o.smd = false -- Don't show mode in cmdline

-- Tabs & Indent
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.autoindent = true
o.smarttab = true
o.linebreak = true
o.breakindent = true

-- Editor
o.wrap = false
o.clipboard = "unnamedplus"
o.foldmethod = "marker"
o.completeopt = "menuone,noselect,menu"
o.lazyredraw = true

-- Search
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.showmatch = true -- Shows show match
o.smartcase = true -- Don't ignore when uppercase search

-- Statusline
o.laststatus = 3
--[[ if utils.has_version "0.8" then
    o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
end ]]
-- o.statusline = "%!v:lua.require'custom.statusline'.run()"
-- o.guifont = "OperatorMonoSSmLig Nerd Font,codicon:h10"
-- o.guifont = "ComicCodeLigatures Nerd Font:codicon:h09"
o.guifont = "MonoLisaNerdFontComplete Nerd Font:h9"

-- Conceal
o.conceallevel = 2

-- See :h fillchars
o.fillchars = {
    eob = " ",
    vert = "║",
    horiz = "═",
    horizup = "╩",
    horizdown = "╦",
    vertleft = "╣",
    vertright = "╠",
    verthoriz = "╬",
}
o.listchars = {
    trail = "·",
    -- eol = "↲",
}

-- Backups / Undo
o.backup = false -- Don't backup files
o.writebackup = false -- Don't write backup
o.undofile = false -- Don't write undofile
o.swapfile = false -- Don't write swapfile

-- Syntax
-- Set C syntax for '.h' header files (default is C++)
vim.g.c_syntax_for_h = true

-- Enable bundled tree-sitter parser for Lua
vim.g.ts_highlight_lua = true

-- Terminal
--[[ if vim.fn.has "win32" == 1 then
    o.shell = "pwsh.exe -nol"
    o.shellcmdflag = "-nop -c"
    o.shellquote = '"'
    o.shellxquote = ""
    o.shellpipe = "| Out-File -Encoding UTF8 %s"
    o.shellredir = "| Out-File -Encoding UTF8 %s"
end ]]

-- Using nu as a shell
-- Commenting this out because it causes error on linux cuz i don't hv nu LMFAO
--[[ vim.opt.shell = "nu"
vim.opt.shellcmdflag = "-c" ]]
