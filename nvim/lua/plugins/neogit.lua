return {
    "neogit",
    keys = {
        {
            "<leader>go",
            function()
                require("neogit").open({ kind = "replace" })
            end,
            noremap = true,
            silent = true,
            desc = "open noegit ui",
        },
        {
            "<leader>gc",
            function()
                require("neogit").open({ "commit" })
            end,
            noremap = true,
            silent = true,
            desc = "git commit",
        },
        {
            "<leader>gw",
            cmd("Gwrite"),
            noremap = true,
            silent = true,
            desc = "git write (add file)",
        },
    },
    after = function()
        require("neogit").setup({
            disable_builtin_notifications = true,
            disable_insert_on_commit = "auto",
            integrations = {
                diffview = false,
                telescope = true,
                fzf_lua = false,
            },
            sections = {
                ---@diagnostic disable-next-line: missing-fields
                recent = {
                    folded = false,
                },
            },
        })
    end,
}
