return {
    "no-neck-pain.nvim",
    keys = {
        { "<leader>c", "<cmd>NoNeckPain<CR>", desc = "center view" },
    },
    after = function()
        require("no-neck-pain").setup({
            width = 120,
            buffers = { colors = { blend = -0.2 } },
        })
    end,
}
