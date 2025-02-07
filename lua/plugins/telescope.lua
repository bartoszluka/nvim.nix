return {
    {
        "telescope.nvim",
        cmd = { "Telescope" },
        -- NOTE: our on attach function defines keybinds that call telescope.
        -- so, the on_require handler will load telescope when we use those.
        on_require = { "telescope" },

        load = function(name)
            vim.cmd.packadd(name)
            vim.cmd.packadd("telescope-ui-select.nvim")
            vim.cmd.packadd("telescope-fzy-native.nvim")
            vim.cmd.packadd("smart-open.nvim")
        end,

        keys = {
            {
                "<leader>/",
                function()
                    -- Slightly advanced example of overriding default behavior and theme
                    -- You can pass additional configuration to telescope to change theme, layout, etc.
                    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    }))
                end,
                mode = { "n" },
                desc = "[/] Fuzzily search in current buffer",
            },
            {
                "<leader>s/",
                function()
                    require("telescope.builtin").live_grep({
                        grep_open_files = true,
                        prompt_title = "Live Grep in Open Files",
                    })
                end,
                mode = { "n" },
                desc = "[S]earch [/] in Open Files",
            },
            {
                "<leader>sb",
                function()
                    return require("telescope.builtin").buffers()
                end,
                mode = { "n" },
                desc = "[ ] Find existing buffers",
            },
            {
                "<leader>s.",
                function()
                    return require("telescope.builtin").oldfiles()
                end,
                mode = { "n" },
                desc = '[S]earch Recent Files ("." for repeat)',
            },
            {
                "<leader>sr",
                function()
                    return require("telescope.builtin").resume()
                end,
                mode = { "n" },
                desc = "[S]earch [R]esume",
            },
            {
                "<leader>sd",
                function()
                    return require("telescope.builtin").diagnostics()
                end,
                mode = { "n" },
                desc = "[S]earch [D]iagnostics",
            },
            {
                "<leader>sg",
                function()
                    return require("telescope.builtin").live_grep()
                end,
                mode = { "n" },
                desc = "[S]earch by [G]rep",
            },
            {
                "<leader>sw",
                function()
                    return require("telescope.builtin").grep_string()
                end,
                mode = { "n" },
                desc = "[S]earch current [W]ord",
            },
            {
                "<leader>ss",
                function()
                    return require("telescope.builtin").builtin()
                end,
                mode = { "n" },
                desc = "[S]earch [S]elect Telescope",
            },
            {
                "<leader>sf",
                function()
                    require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
                end,
                mode = { "n" },
                desc = "[S]earch [F]iles",
            },
            {
                "<leader>sk",
                function()
                    return require("telescope.builtin").keymaps()
                end,
                mode = { "n" },
                desc = "[S]earch [K]eymaps",
            },
            {
                "<leader>sh",
                function()
                    return require("telescope.builtin").help_tags()
                end,
                mode = { "n" },
                desc = "[S]earch [H]elp",
            },
        },
        after = function(plugin)
            local actions = require("telescope.actions")
            local layout_config = {
                vertical = {
                    width = function(_, max_columns)
                        return math.floor(max_columns * 0.99)
                    end,
                    height = function(_, _, max_lines)
                        return math.floor(max_lines * 0.99)
                    end,
                    prompt_position = "bottom",
                    preview_cutoff = 0,
                },
            }
            require("telescope").setup({
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                defaults = {
                    path_display = {
                        "truncate",
                    },
                    layout_strategy = "vertical",
                    layout_config = layout_config,
                    mappings = {
                        i = {
                            ["<C-q>"] = actions.send_to_qflist,
                            ["<C-s>"] = actions.cycle_previewers_next,
                            ["<C-a>"] = actions.cycle_previewers_prev,
                            ["<c-enter>"] = "to_fuzzy_refine",
                        },
                        n = {
                            q = actions.close,
                        },
                    },
                    preview = {
                        treesitter = true,
                    },
                    history = {
                        path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
                        limit = 1000,
                    },
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    vimgrep_arguments = {
                        "rg",
                        "-L",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                },
                -- pickers = {}
                extensions = {
                    fzy_native = {
                        override_generic_sorter = false,
                        override_file_sorter = true,
                    },
                    smart_open = {
                        match_algorithm = "fzy",
                        filename_first = true,
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })

            -- Enable telescope extensions, if they are installed
            -- pcall(require("telescope").load_extension, "ui-select")
            -- pcall(require("telescope").load_extension, "fzy_native")
            -- pcall(require("telescope").load_extension, "smart_open")
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzy_native")
            require("telescope").load_extension("smart_open")
        end,
    },
}
