---@diagnostic disable: undefined-global
local module = [[
local $1 = {}

${0:local test = "test}

return $1
]]

local nmap = [[
map("n", "$1", "$0")
]]

local imap = [[
map("i", "$1", "$0")
]]

local status = [[
local status_ok, ${1:module_var_name} = pcall(require, "${2:module_name}")
if not status_ok then
    return
end
]]

return {
    parse({ trig = "M" }, module),
    parse({ trig = "nmap" }, nmap),
    parse({ trig = "imap" }, imap),
    parse({ trig = "status" }, status),
}
