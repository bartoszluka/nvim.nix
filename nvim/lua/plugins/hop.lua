return {
    "hop",
    keys = {
        {
            "<leader>hw",
            function()
                require("hop").hint_words()
            end,
        },
        {
            "<leader>hc",
            function()
                require("hop").hint_char1()
            end,
        },
        {
            "<leader>hv",
            function()
                require("hop").hint_vertical()
            end,
        },
    },
    after = function()
        require("hop").setup({
            keys = "asdghklqwertyuiopzxcvbnmfj",
        })
        if vim.g.colors_name == "nord" then
            nx.hl({
                { "HopNextKey", fg = "#BF616A", bold = true },
                { "HopNextKey1", fg = "#81A1C1", bold = true },
                { "HopNextKey2", fg = "#5E81AC" },
                { "HopUnmatched", link = "Comment", italic = false },
            })
        end
    end,
}
