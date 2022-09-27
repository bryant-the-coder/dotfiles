local present, devicons = pcall(require, "nvim-web-devicons")
if not present then
    return
end

local options = require("custom.icons").devicons

devicons.setup(options)
