return {
    "mini.ai",
    event = { "BufReadPost", "BufNewFile" },
    after = function()
        local ai = require("mini.ai")
        ai.setup({
            n_lines = 500,
            custom_textobjects = {
                -- Disable brackets alias in favor of builtin block textobject
                o = ai.gen_spec.treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                }),
                a = ai.gen_spec.treesitter({
                    a = { "@parameter.outer" },
                    i = { "@parameter.inner", "@parameter.outer" },
                }),
                f = false,
                -- f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                c = false,
                -- c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                b = false,
                r = ai.gen_spec.pair("[", "]", { type = "balanced" }),
                -- Whole buffer
                e = function()
                    local from = { line = 1, col = 1 }
                    local to = {
                        line = vim.fn.line("$"),
                        col = math.max(vim.fn.getline("$"):len(), 1),
                    }
                    return { from = from, to = to }
                end,
            },
        })
    end,
}
