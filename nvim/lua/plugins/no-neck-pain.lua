return {
    "no-neck-pain.nvim",
    keys = {
        { "<leader>c", "<cmd>NoNeckPain<CR>", desc = "center view" },
    },
    opts = {
        width = 120,
        buffers = { colors = { blend = -0.2 } },
    },
}
