return {
    "bqf",
    ft = "qf",
    after = function()
        require("bqf").setup({
            preview = {
                winblend = 0,
            },
            auto_resize_height = true,
        })
    end,
}
