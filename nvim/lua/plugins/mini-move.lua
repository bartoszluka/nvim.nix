local normal_visual = { "n", "v" }
return {
    "mini.move",
    keys = {
        { "<M-h>", mode = normal_visual },
        { "<M-j>", mode = normal_visual },
        { "<M-k>", mode = normal_visual },
        { "<M-l>", mode = normal_visual },
    },
    after = function()
        require("mini.move").setup({
            options = { reindent_linewise = false },
        })
    end,
}
