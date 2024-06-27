return {
    on_attach = function(client, bufnr)
        vim.notify("attaching " .. client.name)
        nx.map({
            { "gd", vim.lsp.buf.definition, desc = "go to definition" },
            { "<leader>a", vim.lsp.buf.code_action, { "n", "v" }, desc = "code action" },
            { "gi", vim.lsp.buf.implementation, desc = "go to implementation" },
            { "gr", vim.lsp.buf.references, desc = "go to references" },
            { "gh", vim.diagnostic.open_float, desc = "Open diagnostic" },
            { "<leader>ha", vim.lsp.codelens.run, desc = "code lens" },
        }, { buffer = bufnr })
    end,
    make_capabilities = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- Add com_nvim_lsp capabilities
        local cmp_lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities = vim.tbl_deep_extend("keep", capabilities, cmp_lsp_capabilities)
        -- Add any additional plugin capabilities here.
        -- Make sure to follow the instructions provided in the plugin's docs.
        return capabilities
    end,

    servers = {
        "elmls",
        "rust_analyzer",
        "tsserver",
        "lua_ls",
        "cssls",
        -- "csharp_ls",
        -- "omnisharp",
        "kotlin_language_server",
        "basedpyright",
        "clangd",
        "nil_ls",
    },
}
