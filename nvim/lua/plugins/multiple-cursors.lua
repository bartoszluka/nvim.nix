local normal_and_visual = { "n", "x" }
return {
    "multiple-cursors",
    keys = {
        {
            "<C-j>",
            function()
                require("multiple-cursors").add_cursor_down()
            end,
            mode = normal_and_visual,
            desc = "add cursor and move down",
        },
        {
            "<C-k>",
            function()
                require("multiple-cursors").add_cursor_up()
            end,
            mode = normal_and_visual,
            desc = "add cursor and move up",
        },

        { "<C-n>", "<Cmd>MultipleCursorsAddMatches<CR>", mode = normal_and_visual, desc = "add cursors to cword" },
        {
            "<Leader>d",
            "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
            mode = normal_and_visual,
            desc = "Add cursor and jump to next cword",
        },
        {
            "<leader>l",
            "<Cmd>MultipleCursorsLockToggle<CR>",
            mode = normal_and_visual,
            desc = "toggle locking virtual cursors",
        },
    },
    after = function()
        require("multiple-cursors").setup()
    end,
}
