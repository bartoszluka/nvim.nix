return {
    on_attach = function(client, bufnr)
        pcall(vim.keymap.del, "n", "grc")
        nx.map({
            { "gd", vim.lsp.buf.definition, desc = "go to definition" },
            { "<leader>a", vim.lsp.buf.code_action, { "n", "v" }, desc = "code action" },
            { "gi", vim.lsp.buf.implementation, desc = "go to implementation" },
            { "grr", vim.lsp.buf.references, desc = "go to references" },
            { "grn", vim.lsp.buf.rename, desc = "rename" },
            { "gh", vim.diagnostic.open_float, desc = "open diagnostic" },
            { "<leader>ha", vim.lsp.codelens.run, desc = "code lens" },
        }, { buffer = bufnr })
    end,
    make_capabilities = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- Add com_nvim_lsp capabilities
        -- local cmp_lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- capabilities = vim.tbl_deep_extend("keep", capabilities, cmp_lsp_capabilities)
        -- Add any additional plugin capabilities here.
        -- Make sure to follow the instructions provided in the plugin's docs.
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        return capabilities
    end,

    servers = {
        "elmls",
        "rust_analyzer",
        -- "ts_ls",
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
