return {
    "lazydev.nvim",
    cmd = { "LazyDev" },
    ft = "lua",
    after = function()
        require("lazydev").setup({
            library = {
                { words = { "nixCats" }, path = (require("nixCats").nixCatsPath or "") .. "/lua" },
            },
        })
    end,
}
