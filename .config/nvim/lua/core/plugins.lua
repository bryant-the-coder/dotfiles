-- ULES TO FOLLOW :
-- 1. use ({})
-- 2. lazy load ( see :h events )
-- 3. add comment or sections
-- 4. add disable option (plugins.<name_of_plugins>)

-- Lazy load whenever you can :)

local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Cloning packer...\nSettting up config"
    vim.cmd [[packadd packer.nvim]]
end

-- Requiring file that contains all the settings for disabling plugins
local plugins = require("core.default_config").plugins

return require("packer").startup {
    function(use)
        -----------------------------------
        --              Core             --
        -----------------------------------
        use {
            "wbthomason/packer.nvim",
        }

        -----------------------------------
        --          Dependencies         --
        -----------------------------------
        use {
            "nvim-lua/plenary.nvim",
            module = "plenary",
            disable = plugins.plenary,
        }

        use {
            "kyazdani42/nvim-web-devicons",
            module = "nvim-web-devicons",
            config = function()
                require "modules.ui.devicons"
            end,
            disable = plugins.icons,
        }

        -- Theme
        use {
            "bryant-the-coder/base16",
            disable = plugins.base16,
        }

        use {
            "MunifTanjim/nui.nvim",
            -- after = "neo-tree.nvim",
            disable = plugins.nui,
        }

        -----------------------------------
        --           Completion          --
        -----------------------------------
        -- CMP
        use {
            "hrsh7th/nvim-cmp",
            event = { "InsertEnter", "CmdLineEnter" },
            after = { "LuaSnip" },
            requires = {
                {
                    "saadparwaiz1/cmp_luasnip",
                    after = { "nvim-cmp" },
                    disable = plugins.cmp_luasnip,
                },
                { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", disable = plugins.cmp_lsp },
                { "hrsh7th/cmp-buffer", after = "nvim-cmp", disable = plugins.cmp_buffer },
                { "hrsh7th/cmp-path", after = "nvim-cmp", disable = plugins.cmp_path },
            },
            config = function()
                require "modules.completion.cmp"
            end,
            disable = plugins.cmp,
        }

        -- Snippets
        use {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            config = function()
                require "modules.completion.snippets"
            end,
            disable = plugins.luasnip,
        }
        use {
            "bryant-the-coder/friendly-snippets",
            event = "InsertEnter",
            disable = plugins.friendly_snippets,
        }

        -- Autopairs
        use {
            "windwp/nvim-autopairs",
            event = {
                "InsertEnter",
                -- for working with cmp
                "CmdLineEnter",
            },
            after = "nvim-cmp",
            opt = true,
            config = function()
                require "modules.completion.autopairs"
            end,
            disable = plugins.autopairs,
        }

        -----------------------------------
        --             Editor            --
        -----------------------------------
        -- Markdown Preview (seldom use)
        use {
            "iamcco/markdown-preview.nvim",
            run = "cd app && yarn install",
            ft = "markdown",
            cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
            config = function()
                -- Open the default browser
                vim.g.mkdp_browser = "firefox"
            end,
        }

        -- Impatient
        use {
            "lewis6991/impatient.nvim",
            config = function()
                require "modules.editor.impatient"
            end,
            disable = plugins.impatient,
        }

        -- Comment
        use {
            "numToStr/Comment.nvim",
            keys = {
                "gcc",
                "gc",
                "gcb",
                "gb",
                "gco",
                "gcO",
            },
            opt = true,
            requires = {
                "JoosepAlviste/nvim-ts-context-commentstring",
                event = "InsertEnter",
                disable = plugins.commentstring,
            },
            config = function()
                require "modules.editor.comment"
            end,
            disable = plugins.comment,
        }

        -- Neorg
        use {
            "nvim-neorg/neorg",
            ft = "norg",
            after = "nvim-treesitter", -- You may want to specify Telescope here as well
            config = function()
                require "modules.editor.neorg"
            end,
            disable = plugins.neorg,
        }
        use {
            "max397574/neorg-kanban",
            after = "neorg",
            disable = plugins.neorg_kanban,
        }
        use {
            "nvim-neorg/neorg-telescope",
            after = "neorg",
            disable = plugins.neorg_telescope,
        }

        use {
            "edluffy/hologram.nvim",
            config = function()
                require "modules.editor.hologram"
            end,
            disable = plugins.hologram,
        }

        -----------------------------------
        --              Files            --
        -----------------------------------
        -- Nvim-Tree
        use {
            "kyazdani42/nvim-tree.lua",
            opt = true,
            cmd = "NvimTreeToggle",
            tag = "nightly",
            config = function()
                require "modules.files.nvim-tree"
            end,
            disable = plugins.nvim_tree,
        }

        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            cmd = { "Neotree", "NeoTreeShow", "NeoTreeFocus", "NeoTreeFocusToggle" },
            config = function()
                require "modules.files.neo-tree"
            end,
            disable = plugins.neotree,
        }

        -- Harpoon
        use {
            "bryant-the-coder/harpoon",
            setup = function()
                require("custom.load").harpoon()
            end,
            config = function()
                require "modules.files.harpoon"
            end,
            disable = plugins.harpoon,
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            module = { "telescope", "modules.files.telescope" },
            cmd = "Telescope",
            config = function()
                require "modules.files.telescope"
            end,
            disable = plugins.telescope,
        }
        use {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            after = "telescope.nvim",
            disable = plugins.telescope_fzf_native,
        }
        use {
            "nvim-telescope/telescope-file-browser.nvim",
            after = "telescope.nvim",
            disable = plugins.telescope_file_browser,
        }

        -----------------------------------
        --              Git              --
        -----------------------------------
        use {
            "tpope/vim-fugitive",
            after = "gitsigns.nvim",
            cmd = {
                "Git commit",
                "Git add",
            },
            disable = plugins.fugitive,
        }

        -- Git intergrations
        use {
            "lewis6991/gitsigns.nvim",
            -- event = "BufRead",
            opt = true,
            setup = function()
                require("custom.load").git()
            end,
            config = function()
                require "modules.git.gitsigns"
            end,
            disable = plugins.gitsigns,
        }

        use {
            "sindrets/diffview.nvim",
            after = "gitsigns.nvim",
            config = function()
                require "modules.git.diffview"
            end,
            disable = plugins.diffview,
        }

        -----------------------------------
        --            Language           --
        -----------------------------------
        -- Formatter
        use {
            "mhartington/formatter.nvim",
            cmd = "FormatWrite",
            setup = function()
                local group = vim.api.nvim_create_augroup("Formatter", {})
                vim.api.nvim_create_autocmd("BufWritePost", {
                    callback = function()
                        vim.cmd [[FormatWrite]]
                    end,
                    group = group,
                })
            end,
            config = function()
                require "modules.lang.formatter"
            end,
            disable = plugins.formatter,
        }

        -- Neogen
        use {
            "danymat/neogen",
            cmd = "Neogen",
            config = function()
                require "modules.lang.neogen"
            end,
            disable = plugins.neogen,
        }

        -- Null-ls
        use {
            "Jose-elias-alvarez/null-ls.nvim",
            event = { "InsertEnter" },
            config = function()
                require "modules.lang.null-ls"
            end,
            disable = plugins.null,
        }

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            ft = {
                "lua",
                "md",
                "rust",
                "c",
                "cpp",
                "html",
                "css",
                "javascript",
                "typescript",
                "tex",
                "json",
            },
            run = ":TSUpdate",
            event = { "BufRead", "BufNewFile" },
            config = function()
                require "modules.lang.treesitter"
            end,
        }

        -- Vscode like rainbow parenthesis
        use {
            "p00f/nvim-ts-rainbow",
            after = "nvim-treesitter",
            opt = true,
            disable = plugins.ts_rainbow,
        }

        -- Auto complete tag
        use {
            "windwp/nvim-ts-autotag",
            -- ft = { "html", "typescript", "javascripts", "javascriptreact" },
            disable = plugins.autotag,
        }

        use {
            "nvim-treesitter/playground",
            cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
            opt = true,
            disable = plugins.playground,
        }

        use {
            "lewis6991/nvim-treesitter-context",
            after = "nvim-treesitter",
            cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
            disable = plugins.ts_context,
        }

        -- Trouble
        use {
            "folke/trouble.nvim",
            cmd = {
                "Trouble",
                "TroubleRefresh",
                "TroubleClose",
                "TroubleToggle",
            },
            opt = true,
            config = function()
                require "modules.lang.trouble"
            end,
            disable = plugins.trouble,
        }

        -- LSP
        --[[ use({
            "williamboman/nvim-lsp-installer",
            disable = false,
            {
                "neovim/nvim-lspconfig",
                module = "lspconfig",
                event = "BufRead",
                disable = false,
                tag = "v0.1.3",
                config = function()
                    require("plugins.config.lsp")
                end,
            },
        }) ]]
        use {
            "neovim/nvim-lspconfig",
            opt = true,
            ft = {
                "lua",
                "rust",
                "c",
                "cpp",
                "html",
                "css",
                "javascript",
                "typescript",
                "tex",
                "json",
                "vim",
                "python",
            },
            config = function()
                require "modules.lsp.init"
                require "modules.lsp.installer"
            end,
            disable = plugins.lsp,
        }

        -- mason-lspconfig
        use {
            "williamboman/mason-lspconfig.nvim",
            -- after = "mason.nvim",
            disable = plugins.lsp_installer,
        }

        -- Much like lspisntaller, but better
        use {
            "williamboman/mason.nvim",
            --[[ ft = {
                "lua",
                "python",
                "vim",
                "rust",
                "c",
                "cpp",
                "html",
                "css",
                "javascript",
                "typescript",
                "tex",
                "json",
            },
            after = "mason-lspconfig.nvim", ]]
        }

        -- Setting up inlay hints
        use {
            "lvimuser/lsp-inlayhints.nvim",
            after = "nvim-lspconfig",
            disable = plugins.inlay,
            config = function()
                require "modules.lsp.inlay"
            end,
        }

        use {
            "max397574/lua-dev.nvim",
            ft = { "lua" },
            after = "nvim-lspconfig",
            disable = plugins.lua_dev,
        }

        use {
            "p00f/clangd_extensions.nvim",
            -- ft = { "c", "cpp" },
            requires = "nvim-lspconfig",
            disable = plugins.clangd_ext,
        }

        use {
            "ray-x/lsp_signature.nvim",
            after = "nvim-lspconfig",
            config = function()
                require "modules.lsp.signature"
            end,
            disable = plugins.lsp_signature,
        }

        -- Uncomment this if you want lspsage
        use {
            "glepnir/lspsaga.nvim",
            after = "nvim-lspconfig",
            config = function()
                require "modules.lsp.saga"
            end,
            disable = plugins.lspsaga,
        }

        -----------------------------------
        --             Tools             --
        -----------------------------------
        use {
            "rcarriga/nvim-dap-ui",
            config = function()
                require "modules.tools.dapui"
            end,
            after = "nvim-dap",
            disable = plugins.dapui,
        }

        use {
            "mfussenegger/nvim-dap",
            config = function()
                require "modules.tools.dap"
            end,
            after = "nvim-lspconfig",
            disable = plugins.dap,
        }

        use {
            "mfussenegger/nvim-dap-python",
            after = "nvim-dap",
            disable = plugins.dap_python,
        }

        -- Quickly move around tabs
        use {
            "ghillb/cybu.nvim",
            branch = "main", -- timely updates
            disable = plugins.cybu,
            config = function()
                require "modules.tools.cybu"
            end,
        }

        use {
            "zbirenbaum/neodim",
            event = "LspAttach",
            disable = plugins.neodim,
            config = function()
                require "modules.tools.neodim"
            end,
        }

        -- Hex colours
        use {
            "NvChad/nvim-colorizer.lua",
            opt = true,
            setup = function()
                require("custom.load").colorizer()
            end,
            config = function()
                require "modules.tools.colorizer"
            end,
            disable = plugins.colorizer,
        }

        -- Change colors live in a window
        use {
            "max397574/colortils.nvim",
            cmd = "Colortils",
            config = function()
                require "modules.tools.colortils"
            end,
            disable = plugins.colortils,
        }

        -- Show lsp progress when you enter a file
        use {
            "j-hui/fidget.nvim",
            module = "lspconfig",
            config = function()
                require "modules.tools.fidget"
            end,
            disable = plugins.fidget,
        }

        -- Terminal
        use {
            "akinsho/toggleterm.nvim",
            keys = "<c-b>",
            module = { "toggleterm" },
            config = function()
                require "modules.tools.toggleterm"
            end,
            disable = plugins.toggleterm,
        }

        -- Share code
        use {
            "rktjmp/paperplanes.nvim",
            cmd = "PP",
            disable = plugins.paperplanes,
        }

        -- Faster movement
        use {
            "ggandor/lightspeed.nvim",
            keys = { "S", "s", "f", "F", "t", "T" },
            config = function()
                require "modules.tools.lightspeed"
            end,
            disable = plugins.lightspeed,
        }

        use {
            "folke/todo-comments.nvim",
            after = "nvim-treesitter",
            config = function()
                require "modules.tools.todo"
            end,
            disable = plugins.todo_comments,
        }

        use {
            "kylechui/nvim-surround",
            after = "nvim-treesitter",
            config = function()
                require "modules.tools.surround"
            end,
            disable = plugins.nvim_surround,
        }

        use {
            "RRethy/nvim-align",
            disable = plugins.align,
        }

        -----------------------------------
        --               UI              --
        -----------------------------------
        -- True zen
        use {
            "Pocco81/TrueZen.nvim",
            cmd = {
                "TZAtaraxis",
                "TZMinimalist",
                "TZFocus",
            },
            disable = plugins.true_zen,
            config = function()
                require "modules.ui.zen"
            end,
        }

        -- Presence
        use {
            "andweeb/presence.nvim",
            opt = true,
            setup = function()
                require("custom.load").on_file_open "presence.nvim"
            end,
            disable = plugins.presence,
        }

        -- Bufferline
        use {
            "akinsho/bufferline.nvim",
            opt = true,
            -- Taken from https://github.com/max397574/omega-nvim
            setup = function()
                require("custom.load").bufferline()
            end,
            config = function()
                require "modules.ui.bufferline"
            end,
            disable = plugins.bufferline,
        }

        -- Indentation
        use {
            "lukas-reineke/indent-blankline.nvim",
            setup = function()
                require("custom.load").blankline()
            end,
            config = function()
                require "modules.ui.indent"
            end,
            disable = plugins.indent_blankline,
        }

        -- Notifications
        use {
            "rcarriga/nvim-notify",
            opt = true,
            event = "BufEnter",
            config = function()
                require "modules.ui.notify"
            end,
            disable = plugins.notify,
        }

        use {
            "lewis6991/satellite.nvim",
            after = "bufferline.nvim",
            config = function()
                require "modules.ui.satellite"
            end,
            disable = plugins.satellite,
        }

        -- Install packer and plugins if it doesn't exist
        if BOOTSTRAP then
            require("packer").sync()
        end
    end,
    config = {
        profile = {
            enable = true,
            threshold = 0.0001,
        },
        display = {
            title = "Packer", -- Packer, Installing
            working_sym = "ﲊ",
            error_sym = "✗ ",
            done_sym = " ",
            removed_sym = " ",
            moved_sym = "",
            --[[ open_fn = function()
                return require("packer.util").float { border = "single" }
            end, ]]
        },
        -- Uncomment this if your pc slows down
        -- max_jobs = 6,
    },
}
