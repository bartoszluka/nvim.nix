return {
    "mini.pairs",
    event = { "InsertEnter" },
    after = function()
        require("mini.pairs").setup()
    end,
}
