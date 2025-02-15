return {
    "mini.bufremove",
    keys = {
        {
            "<leader>x",
            function()
                require("mini.bufremove").delete(0, false)
            end,
            desc = "delete buffer",
        },
        {
            "<leader>X",
            function()
                require("mini.bufremove").delete(0, true)
            end,
            desc = "delete buffer (force)",
        },
    },
}
