local normal_visual = { "n", "v" }
return {
    "mini.move",
    keys = {
        { "A-h", mode = normal_visual },
        { "A-j", mode = normal_visual },
        { "A-k", mode = normal_visual },
        { "A-l", mode = normal_visual },
    },
    after = function()
        require("mini.move").setup({
            options = { reindent_linewise = false },
        })
    end,
}
