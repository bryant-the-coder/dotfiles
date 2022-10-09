local base16 = require "base16"

-- Theme that I like:
-- A) onedark
-- B) kanagawa
-- C) everforest
-- D) mocha

-- TODO: might add a timer for theme
_G.theme = "everblush"

local theme = _G.theme
-- vim.cmd [[colorscheme everblush]]
return base16(base16.themes(theme))
