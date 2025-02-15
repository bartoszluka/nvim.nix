return {
    "nvim-surround",
    -- event = "DeferredUIEnter",
    keys = { "ys", "cs", "ds", { "s", mode = "v" } },
    after = function()
        require("nvim-surround").setup({
            keymaps = {
                visual = "s",
            },
            highlight = { duration = 200 },
            aliases = {
                ["q"] = { '"', "'", "`" },
                ["s"] = {
                    "{",
                    "[",
                    "(",
                    "<",
                    '"',
                    "'",
                    "`",
                },
                ["b"] = ")",
                ["r"] = "]",
                ["B"] = "}",
            },
            surrounds = {
                -- -- TODO: do this just for lua
                -- f = {
                --     add = { "function() ", " end" },
                --     delete = get_function_definition_range,
                --     change = {
                --         target = get_function_definition_range,
                --         replacement = function()
                --             local config = require("nvim-surround.config")
                --             local input = require("nvim-surround.input")
                --             local ins_char = input.get_char()
                --             local delimiters = config.get_delimiters(ins_char, false)
                --             return delimiters
                --         end,
                --     },
                -- },
                q = { add = { '"', '"' } },
            },
            indent_lines = false,
            move_cursor = false,
        })
    end,
}
