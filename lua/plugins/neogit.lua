return {
    "neogit",
    cmd = { "Neogit", "NeogitLog", "NeogitCommit" },
    keys = { { "<leader>gg", cmd("Neogit") } },
    after = function()
        require("neogit").setup({
            graph_style = "unicode",
            git_services = {
                ["netcompany.com"] = "https://source.netcompany.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
            },

            telescope_sorter = function()
                return require("telescope").extensions.fzy_native.native_fzy_sorter()
            end,

            initial_branch_name = "feature/",
            kind = "auto",
            integrations = { telescope = true },
            commit_editor = {
                ["<c-p>"] = "PrevMessage",
                ["<c-n>"] = "NextMessage",
                ["<c-e>"] = "Abort",
            },
        })
    end,
}
