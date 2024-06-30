local normal_visual = { "n", "x" }
return {
    "mini.clue",
    keys = {
        { "<leader>", mode = normal_visual },
        { "g", mode = normal_visual },
        { "z", mode = normal_visual },
        { '"', mode = normal_visual },
        { "<C-w>", mode = normal_visual },
        { "<C-r>", mode = { "i", "c" } },
    },
    after = function()
        local clue = require("mini.clue")
        clue.setup({
            triggers = {
                { mode = "n", keys = "<leader>" },
                { mode = "x", keys = "<leader>" },

                { mode = "n", keys = "g" },
                { mode = "v", keys = "g" },

                -- registers
                { mode = "n", keys = '"' },
                { mode = "v", keys = '"' },
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },

                { mode = "n", keys = "<C-w>" },

                { mode = "n", keys = "z" },
                { mode = "v", keys = "z" },
            },
            clues = {
                clue.gen_clues.g(),
                clue.gen_clues.marks(),
                clue.gen_clues.registers(),
                clue.gen_clues.windows(),
                clue.gen_clues.z(),
            },
            window = {
                config = {},
                delay = 1000,
                scroll_up = "<c-u>",
                scroll_down = "<c-d>",
            },
        })
    end,
}
