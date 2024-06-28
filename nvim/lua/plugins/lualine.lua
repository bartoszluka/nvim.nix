return {
    "lualine",
    event = "DeferredUIEnter",
    after = function()
        local theme = vim.g.colors_name

        local function fg(name)
            return function()
                ---@type {foreground?:number}?
                local hl = vim.api.nvim_get_hl_by_name(name, true)
                return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
            end
        end
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = theme,
                component_separators = "|",
                section_separators = "",
                disabled_filetypes = {
                    statusline = {
                        "dashboard",
                        "lazy",
                        "alpha",
                        "TelescopePrompt",
                    },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    {
                        "diff",
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        newfile_status = true,
                        -- symbols = {
                        --     modified = "●",
                        --     readonly = "",
                        --     unnamed = "",
                        -- },
                        color = { gui = "bold" },
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        symbols = {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " ",
                        },
                    },
                    {
                        function()
                            local clients = vim.lsp.get_clients({ bufnr = 0 })

                            local just_names = vim.iter(clients)
                                :map(function(client)
                                    return client.name
                                end)
                                :totable()
                            return table.concat(just_names, ", ")
                        end,
                        icon = " ",
                        color = fg("@function.call"),
                    },
                },
                lualine_y = {
                    "encoding",
                    { "filetype", icon_only = false },
                },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                "fugitive",
                "quickfix",
                "oil",
                "trouble",
            },
        })
    end,
}
