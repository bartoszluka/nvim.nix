return {
    "tree-pairs",
    event = "DeferredUIEnter",
    after = function()
        require("tree-pairs").setup()
    end,
}
