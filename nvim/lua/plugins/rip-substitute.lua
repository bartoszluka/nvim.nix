return {
    "rip-substitute",
    keys = {
        {
            "<leader>rs",
            function()
                require("rip-substitute").sub()
            end,
            mode = { "n", "x" },
            desc = "rip substitute",
        },
    },
}
