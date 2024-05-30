return {
    on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end

            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end
        local nvmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end

            vim.keymap.set({ "n", "v" }, keys, func, { buffer = bufnr, desc = desc })
        end
        nvmap("<leader>a", vim.lsp.buf.code_action, "code action") -- managed by clear-action

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        -- nmap("gd", "<cmd>TroubleToggle lsp_definitions<cr>", "[G]oto [D]efinition")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        --     border = "rounded",
        -- })
        nmap("K", function()
            vim.lsp.buf.hover()
        end, "hover")
        nmap("gr", "<cmd>TroubleToggle lsp_references<cr>", "[G]oto [D]efinition")
        nmap("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        nmap("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- nmap("<leader>f", function()
        --     vim.lsp.buf.format({ async = true })
        -- end, "Format file")
        -- See `:help K` for why this keymap
        -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        -- nmap("gh", vim.lsp.buf.signature_help, "Signature Documentation")
        nmap("gh", vim.diagnostic.open_float, "Open diagnostic")

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        nmap("<leader>ha", vim.lsp.codelens.run, "code lens")
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        -- nmap('<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[W]orkspace [L]ist Folders')
        -- NOTE: hacky workaround for semantic tokens
        -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
    end,
    -- nvim-cmp supports additional completion capabilities
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    servers = {
        "elmls",
        "rust_analyzer",
        "tsserver",
        "lua_ls",
        "cssls",
        -- "csharp_ls",
        -- "omnisharp",
        "rnix",
        "kotlin_language_server",
        "basedpyright"
        -- "clangd",
    },
}
