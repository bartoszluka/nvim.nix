return {
    "gitsigns.nvim",
    event = "DeferredUIEnter",
    after = function()
        require("gitsigns").setup({
            -- See `:help gitsigns.txt`
            current_line_blame = false,
            current_line_blame_opts = {
                ignore_whitespace = true,
            },
            -- signs = {
            --     add = { text = "+" },
            --     change = { text = "~" },
            --     delete = { text = "_" },
            --     topdelete = { text = "‾" },
            --     changedelete = { text = "~" },
            -- },
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signs_staged = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signs_staged_enable = true,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", function()
                    if vim.wo.diff then
                        return "]g"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "git next hunk" })

                map("n", "[h", function()
                    if vim.wo.diff then
                        return "[g"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "git previous hunk" })

                -- Actions
                map("v", "<leader>hs", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "git hunk stage" })
                map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })

                map("v", "<leader>hr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "reset hunk git" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })

                map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = false })
                end, { desc = "git blame line" })
                map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end, { desc = "git diff against last commit" })

                -- Toggles
                map("n", "<leader>glb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
                map("n", "<leader>gtd", gs.toggle_deleted, { desc = "toggle git show deleted" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
            end,
        })
    end,
}
