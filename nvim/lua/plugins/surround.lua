local function get_function_definition_range()
    local config = require("nvim-surround.config")
    local whole_function = config.get_selection({ node = "function_definition" })
    local body = config.get_selection({ node = "block" })
    if body.first_pos[2] > 1 then
        body.first_pos[2] = body.first_pos[2] - 1
    end
    return {
        left = {
            first_pos = whole_function.first_pos,
            last_pos = body.first_pos,
        },
        right = {
            first_pos = body.last_pos,
            last_pos = whole_function.last_pos,
        },
    }
end
return {
    "nvim-surround",
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
                -- TODO: do this just for lua
                f = {
                    add = { "function() ", " end" },
                    delete = get_function_definition_range,
                    change = {
                        target = get_function_definition_range,
                        replacement = function()
                            local config = require("nvim-surround.config")
                            local input = require("nvim-surround.input")
                            local ins_char = input.get_char()
                            local delimiters = config.get_delimiters(ins_char, false)
                            return delimiters
                        end,
                    },
                },
                q = { add = { '"', '"' } },
            },
            indent_lines = false,
            move_cursor = false,
        })
    end,
}
