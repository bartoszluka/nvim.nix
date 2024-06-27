return {
    "csharp.nvim",
    ft = "cs",
    after = function()
        nx.au({
            "LspAttach",
            -- pattern = "cs",
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil or client.name ~= "omnisharp" then
                    return
                end
                nx.map({
                    {
                        "gd",
                        function()
                            require("csharp").go_to_definition()
                        end,
                        desc = "Go to Definition",
                    },
                }, { silent = true, nowait = true, noremap = true, buffer = bufnr })
                nx.hl({ "@parameter", link = "@variable.parameter" })
            end,
            desc = "add mappings to omnisharp",
            create_group = "CsharpNvim",
        })
        require("csharp").setup({ -- These are the default values
            lsp = {
                enable = true,
                -- When set to true, csharp.nvim won't install omnisharp automatically and use it via mason.
                -- Instead, the omnisharp instance in the cmd_path will be used.
                cmd_path = nil,
                -- The default timeout when communicating with omnisharp
                default_timeout = 1000,
                -- Settings that'll be passed to the omnisharp server
                enable_editor_config_support = true,
                organize_imports = false,
                load_projects_on_demand = true,
                enable_analyzers_support = true,
                enable_import_completion = true,
                include_prerelease_sdks = true,
                analyze_open_documents_only = true,
                enable_package_auto_restore = true,

                -- Launches omnisharp in debug mode
                debug = false,
                -- The capabilities to pass to the omnisharp server
                capabilities = require("my.lsp").capabilities,
                -- on_attach function that'll be called when the LSP is attached to a buffer
                on_attach = require("my.lsp").on_attach,
            },
            logging = {
                -- The minimum log level.
                level = "INFO",
            },
            dap = {
                adapter_name = nil,
            },
        })
    end,
}
