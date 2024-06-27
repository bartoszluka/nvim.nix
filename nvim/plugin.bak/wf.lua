require("wf").setup({ theme = "default" })
local which_key = require("wf.builtin.which_key")
local register = require("wf.builtin.register")
local buffer = require("wf.builtin.buffer")
local mark = require("wf.builtin.mark")

nx.map({
    {
        -- Register
        "<leader>sr",
        -- register(opts?: table) -> function
        -- opts?: option
        register(),
        noremap = true,
        silent = true,
        desc = "[wf.nvim] register",
    },
    {
        -- Buffer
        "<leader>sb",
        -- buffer(opts?: table) -> function
        -- opts?: option
        buffer(),
        noremap = true,
        silent = true,
        desc = "[wf.nvim] buffer",
    },
    {
        -- Mark
        "'",
        -- mark(opts?: table) -> function
        -- opts?: option
        mark(),
        nowait = true,
        noremap = true,
        silent = true,
        desc = "[wf.nvim] mark",
    },

    -- Which Key
    {
        "<leader>",
        -- mark(opts?: table) -> function
        -- opts?: option
        which_key({ text_insert_in_advance = "<Leader>" }),
        noremap = true,
        silent = true,
        desc = "[wf.nvim] which-key /",
    },
})
