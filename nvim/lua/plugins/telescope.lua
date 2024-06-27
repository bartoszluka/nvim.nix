return {
    "telescope",
    keys = { "<leader>sf", "leader<sg>" },

    after = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        local builtin = require("telescope.builtin")

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

        vim.keymap.set("n", "<leader>sf", function()
            telescope.extensions.smart_open.smart_open({ cwd_only = true })
        end, { desc = "search files" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "live grep" })
        vim.keymap.set("n", "<leader>sq", builtin.command_history, { desc = "command history" })
        vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "lsp document symbols" })
        vim.keymap.set("n", "<leader>sS", builtin.lsp_dynamic_workspace_symbols, { desc = "lsp workspace symbols" })

        telescope.setup({
            defaults = {
                path_display = {
                    "truncate",
                },
                layout_strategy = "vertical",
                layout_config = layout_config,
                mappings = {
                    i = {
                        ["<C-q>"] = actions.send_to_qflist,
                        ["<C-l>"] = actions.send_to_loclist,
                        -- ['<esc>'] = actions.close,
                        ["<C-s>"] = actions.cycle_previewers_next,
                        ["<C-a>"] = actions.cycle_previewers_prev,
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
            extensions = {
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                },
            },
        })

        telescope.load_extension("fzy_native")
        telescope.load_extension("smart_open")
    end,
}
