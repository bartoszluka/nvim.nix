return {
    {
        "nvim-autopairs",
        event = "InsertEnter",
        after = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        after = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            cmp.setup({
                method = "getCompletionsCycling",
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                        -- luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                preselect = cmp.PreselectMode.Item,
                mapping = {
                    ["<C-n>"] = cmp.mapping(
                        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                        { "i", "s", "c" }
                    ),
                    ["<C-p>"] = cmp.mapping(
                        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                        { "i", "s", "c" }
                    ),
                    ["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i", "s", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["C-h"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                },
                sources = {
                    -- { name = "codeium" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
                formatting = {
                    format = function(_, item)
                        local icons = {
                            Array = " ",
                            Boolean = " ",
                            Class = " ",
                            Color = " ",
                            Constant = " ",
                            Constructor = " ",
                            Copilot = " ",
                            Codeium = "󰘦 ",
                            Enum = " ",
                            EnumMember = " ",
                            Event = " ",
                            Field = " ",
                            File = " ",
                            Folder = " ",
                            Function = " ",
                            Interface = " ",
                            Key = " ",
                            Keyword = " ",
                            Method = " ",
                            Module = " ",
                            Namespace = " ",
                            Null = " ",
                            Number = " ",
                            Object = " ",
                            Operator = " ",
                            Package = " ",
                            Property = " ",
                            Reference = " ",
                            Snippet = " ",
                            String = " ",
                            Struct = " ",
                            Text = " ",
                            TypeParameter = " ",
                            Unit = " ",
                            Value = " ",
                            Variable = " ",
                        }
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                -- view = { entries = "native" },
                -- experimental = {
                --     ghost_text = {
                --         hl_group = "LspCodeLens",
                --         native_menu = false,
                --     },
                -- },
                enabled = function()
                    return vim.bo[0].buftype ~= "prompt"
                end,
            })
            cmp.setup.filetype("lua", {
                sources = cmp.config.sources({
                    { name = "nvim_lua" },
                    { name = "nvim_lsp", keyword_length = 3 },
                    { name = "path" },
                }),
            })

            cmp.setup.filetype("fish", {
                sources = cmp.config.sources({ { name = "fish" } }),
            })
            -- Fix for autopairs with cmp
            -- cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

            -- `/` cmdline setup.
            cmp.setup.cmdline({ "/", "?" }, {
                sources = {
                    { name = "nvim_lsp_document_symbol", keyword_length = 3 },
                    { name = "buffer" },
                    -- { name = "cmdline_history" },
                },
                view = {
                    entries = { name = "wildmenu", separator = "|" },
                },
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                    { { name = "cmdline_history" } },
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
                -- sources = cmp.config.sources(
                --     { name = "path" }
                -- { { name = "cmdline_history" } }
                -- ),
            })

            cmp.setup.filetype("gitcommit", {
                sources = {
                    { name = "commit" },
                },
            })
        end,
    },
}
