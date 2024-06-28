return {
    "wf",
    keys = { "<leader>" },
    after = function()
        local which_key = require("wf.builtin.which_key")
        nx.map({
            "<leader>",
            which_key({
                text_insert_in_advance = "<leader>",
                noremap = true,
                silent = true,
                desc = "[wf.nvim] which-key /",
            }),
        })
    end,
}
