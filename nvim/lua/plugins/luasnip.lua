return {
    "luasnip",
    after = function()
        local ls = require("luasnip")
        -- some shorthands...
        local s = ls.snippet
        local sn = ls.snippet_node
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local c = ls.choice_node
        local d = ls.dynamic_node
        local r = ls.restore_node

        -- args is a table, where 1 is the text in Placeholder 1, 2 the text in
        -- placeholder 2,...
        local function copy(args)
            return args[1]
        end
        ls.add_snippets("cs", {
            -- lambda
            s("lm", {
                i(1, "x"),
                t(" => "),
                f(copy, 1),
            }),
            -- throw NotImplementedException
            s("nim", {
                t({
                    "throw new NotImplementedException();",
                    "",
                }),
            }),
        })
    end,
    opts = {
        history = true,
        delete_check_events = "TextChanged",
    },
}
