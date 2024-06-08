-- Exit if the language server isn't available
if vim.fn.executable("clangd") ~= 1 then
    return
end

local root_files = {
    "Makefile",
    "default.nix",
    "shell.nix",
    "main.c",
    ".git",
}

vim.lsp.start({
    name = "clangd",
    cmd = { "clangd" },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    capabilities = require("user.lsp").make_client_capabilities(),
})
