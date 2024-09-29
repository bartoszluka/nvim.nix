return {
    "scratch",
    keys = {
        {
            "<leader>SS",
            function()
                require("scratch").create()
            end,
        },
        {
            "<leader>Sl",
            function()
                require("scratch").create({ filetype = "lua" })
            end,
        },
    },
    after = function()
        require("scratch").setup({
            -- your custom configuration
        })
    end,
}
