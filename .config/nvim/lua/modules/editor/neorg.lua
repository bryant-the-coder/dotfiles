local present, neorg = pcall(require, "neorg")
if not present then
    return
end

local neorg_callbacks = require "neorg.callbacks"

neorg.setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    home = "~/dev/neorg",
                    notes = "~/dev/neorg/notes",
                    task = "~/dev/neorg/task",
                },
                open_last_workspace = false,
            },
        },
        ["core.norg.esupports.metagen"] = {
            config = {
                type = "auto",
            },
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {
            config = {
                extensions = "all",
            },
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.gtd.base"] = {
            config = {
                workspace = "task",
            },
        },
        ["core.norg.concealer"] = {
            config = {
                -- markup_preset = "dimmed",
                markup_preset = "conceal",
                -- icon_preset = "diamond",
                -- icon_preset = "varied",
                dim_code_blocks = {
                    width = "content",
                    padding = {
                        left = 10,
                        right = 10,
                    },
                },
                icons = {
                    marker = {
                        enabled = true,
                        icon = " ",
                    },
                    todo = {
                        enable = true,
                        recurring = {
                            -- icon="ﯩ",
                            icon = "",
                        },
                        pending = {
                            -- icon = ""
                            icon = "",
                        },
                        uncertain = {
                            icon = "?",
                        },
                        urgent = {
                            icon = "",
                        },
                        on_hold = {
                            icon = "",
                        },
                        cancelled = {
                            icon = "",
                        },
                    },
                    heading = {
                        enabled = true,
                        level_1 = {
                            icon = "◈",
                        },

                        level_2 = {
                            icon = " ◇",
                        },

                        level_3 = {
                            icon = "  ◆",
                        },
                        level_4 = {
                            icon = "   ❖",
                        },
                        level_5 = {
                            icon = "    ⟡",
                        },
                        level_6 = {
                            icon = "     ⋄",
                        },
                    },
                },
            },
        },
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.remap_event("norg", "n", "lp", "core.norg.qol.todo_items.todo.task_cycle")
                end,
            },
        },
        ["core.norg.journal"] = {
            config = {
                workspace = "home",
                journal_folder = "journal",
                use_folders = false,
                strategy = "flat",
                toc_format = "{dd, mm, yy}",
            },
        },
        -- ["external.kanban"] = {},
        -- ["core.integrations.telescope"] = {}, -- Enable the telescope module
    },
}

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
            { "<C-f>", "core.integrations.telescope.find_linkable" },
        },

        i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
        },
    }, {
        silent = true,
        noremap = true,
    })
end)
