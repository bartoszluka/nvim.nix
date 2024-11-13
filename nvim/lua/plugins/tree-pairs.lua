return {
    "tree-pairs",
    event = "DeferredUIEnter",
    enabled = false,
    after = function()
        require("tree-pairs").setup()
    end,
}
