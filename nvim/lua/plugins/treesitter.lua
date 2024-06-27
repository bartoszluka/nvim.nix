return {
    "nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    before = function()
        vim.g.skip_ts_context_commentstring_module = true
    end,
    after = function()
        -- treesitter context commentstring configuration
        require("ts_context_commentstring").setup({
            enable_autocmd = false,
        })
        local get_option = vim.filetype.get_option
        vim.filetype.get_option = function(filetype, option)
            return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
                or get_option(filetype, option)
        end

        -- treesitter configuration
        require("nvim-treesitter.configs").setup({
            -- Add languages to be installed here that you want installed for treesitter
            highlight = { enable = true, disable = { "latex" } },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    node_decremental = "<c-backspace>",
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
                        ["aC"] = "@call.outer",
                        ["iC"] = "@call.inner",
                        ["agc"] = "@comment.outer",
                        ["igc"] = "@comment.outer",
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.outer",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["aP"] = "@parameter.outer",
                        ["iP"] = "@parameter.inner",
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
            max_lines = 7, -- How many lines the window should span. Values <= 0 mean no limit.
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
-- local configs = require("nvim-treesitter.configs")
--
-- ---@diagnostic disable-next-line: missing-fields
-- configs.setup({
--     -- ensure_installed = 'all',
--     -- auto_install = false, -- Do not automatically install missing parsers when entering buffer
--     highlight = {
--         enable = true,
--         disable = function(_, buf)
--             local max_filesize = 100 * 1024 -- 100 KiB
--             local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--             if ok and stats and stats.size > max_filesize then
--                 return true
--             end
--         end,
--     },
--     textobjects = {
--         select = {
--             enable = true,
--             -- Automatically jump forward to textobject, similar to targets.vim
--             lookahead = true,
--             keymaps = {
--                 ["af"] = "@function.outer",
--                 ["if"] = "@function.inner",
--                 ["ac"] = "@class.outer",
--                 ["ic"] = "@class.inner",
--                 ["aC"] = "@call.outer",
--                 ["iC"] = "@call.inner",
--                 ["agc"] = "@comment.outer",
--                 ["igc"] = "@comment.outer",
--                 ["ai"] = "@conditional.outer",
--                 ["ii"] = "@conditional.outer",
--                 ["al"] = "@loop.outer",
--                 ["il"] = "@loop.inner",
--                 ["aP"] = "@parameter.outer",
--                 ["iP"] = "@parameter.inner",
--             },
--             selection_modes = {
--                 ["@parameter.outer"] = "v", -- charwise
--                 ["@function.outer"] = "V", -- linewise
--                 ["@class.outer"] = "V", -- blockwise
--             },
--         },
--         swap = {
--             enable = true,
--             swap_next = {
--                 ["<leader>ca"] = "@parameter.inner",
--             },
--             swap_previous = {
--                 ["<leader>cA"] = "@parameter.inner",
--             },
--         },
--         move = {
--             enable = true,
--             set_jumps = true, -- whether to set jumps in the jumplist
--             goto_next_start = {
--                 ["]m"] = "@function.outer",
--                 ["]P"] = "@parameter.outer",
--             },
--             goto_next_end = {
--                 ["]m"] = "@function.outer",
--                 ["]P"] = "@parameter.outer",
--             },
--             goto_previous_start = {
--                 ["[m"] = "@function.outer",
--                 ["[P"] = "@parameter.outer",
--             },
--             goto_previous_end = {
--                 ["[m"] = "@function.outer",
--                 ["[P"] = "@parameter.outer",
--             },
--         },
--         nsp_interop = {
--             enable = true,
--             peek_definition_code = {
--                 ["df"] = "@function.outer",
--                 ["dF"] = "@class.outer",
--             },
--         },
--     },
-- })
--
-- require("treesitter-context").setup({
--     max_lines = 3,
-- })
--
-- require("ts_context_commentstring").setup()
--
-- -- Tree-sitter based folding
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
