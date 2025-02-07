return {
    "nvim-treesitter",
    -- event = { "BufReadPost", "BufNewFile" },
    event = "DeferredUIEnter",

    -- before = function()
    --     ---@diagnostic disable-next-line: inject-field
    --     vim.g.skip_ts_context_commentstring_module = true
    -- end,

    load = function(name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("nvim-treesitter-textobjects")
        vim.cmd.packadd("nvim-treesitter-context")
    end,
    after = function()
        -- treesitter configuration
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true, disable = { "latex" } },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = ";",
                    node_decremental = ",",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobject, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["agc"] = "@comment.outer",
                        ["igc"] = "@comment.outer",
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.outer",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        -- parameter next
                        ["<leader>pn"] = "@parameter.inner",
                    },
                    swap_previous = {
                        -- parameter previous
                        ["<leader>pp"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]P"] = "@parameter.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]P"] = "@parameter.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[P"] = "@parameter.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[P"] = "@parameter.outer",
                    },
                },
                nsp_interop = {
                    enable = true,
                    peek_definition_code = {
                        ["df"] = "@function.outer",
                        ["dF"] = "@class.outer",
                    },
                },
                selection_modes = {
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "V",
                    ["@block.outer"] = "V",
                    ["@conditional.outer"] = "V",
                    ["@loop.outer"] = "V",
                },
            },
            autotag = { enable = true },
        })
        require("treesitter-context").setup({
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
        nx.map({
            {
                "gC",
                function()
                    require("treesitter-context").go_to_context()
                end,
                silent = true,
            },
        })
    end,
}
