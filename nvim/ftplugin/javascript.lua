-- Exit if the language server isn't available
if vim.fn.executable("tsserver") ~= 1 then
    return
end

local root_files = {
    "package.json",
    "tsconfig.json",
    "default.nix",
    ".git",
}

vim.lsp.start({
    init_options = { hostInfo = "neovim" },
    name = "tsserver",
    cmd = { "typescript-language-server", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    capabilities = require("user.lsp").make_client_capabilities(),
    single_file_support = true,
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
})
