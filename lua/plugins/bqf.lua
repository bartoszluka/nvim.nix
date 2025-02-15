return {
    "nvim-bqf",
    ft = "qf",
    after = function()
        require("bqf").setup({
            auto_resize_height = true,
            preview = {
                winblend = 0,
            },
        })
    end,
}
