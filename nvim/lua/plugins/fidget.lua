return {
    "j-hui/fidget.nvim",
    after = function()
        require("fidget").setup({})
    end,
    event = { "LspAttach" },
    tag = "v1.2.0",
}
