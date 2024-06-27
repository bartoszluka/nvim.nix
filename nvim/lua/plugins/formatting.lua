return {
    "conform",
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({
                    async = true,
                    lsp_fallback = true,
                })
            end,
            desc = "format file",
        },
    },
    after = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "ruff_format" },
                -- Use a sub-list to run only the first available formatter
                javascript = { { "biome", "prettierd", "prettier" } },
                yaml = { { "prettierd", "prettier" } },
                json = { { "biome", "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                fish = { "fish_indent" },
                xml = { "xq" },
                sh = { "shfmt" },
                c = { "clang_format" },
                cs = { "csharpier" },
                fsharp = { "fantomas" },
                markdown = { "mdslw", "mdformat", "markdown-toc" },
                nix = { "alejandra" },
                haskell = { "fourmolu" },
                tex = { "latexindent", "trim_whitespace" },
                -- ["*"] = { "codespell" },
                -- ["_"] = { "trim_whitespace" },
            },

            formatters = {
                biome = {
                    command = "biome",
                    stdin = true,
                    args = { "format", "--indent-style=space", "--stdin-file-path", "$FILENAME" },
                    cwd = require("conform.util").root_file({ ".editorconfig" }),
                },
                fourmolu = {
                    range_args = function(ctx)
                        return { "--start-line", ctx.range.start[1], "--end-line", ctx.range["end"][1] }
                    end,
                },
                alejandra = {
                    command = "alejandra",
                    args = { "-qq" },
                    stdin = true,
                },
                mdslw = {
                    prepend_args = { "--max-width", "110" },
                },
                fantomas = {
                    command = "fantomas",
                    args = { "$FILENAME" },
                    stdin = false,
                },
                xq = {
                    -- This can be a string or a function that returns a string.
                    -- When defining a new formatter, this is the only field that is *required*
                    command = "xq",
                    -- A list of strings, or a function that returns a list of strings
                    -- Return a single string instead of a list to run the command in a shell
                    args = { "--indent", "4" },

                    -- Send file contents to stdin, read new contents from stdout (default true)
                    -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
                    -- file is assumed to be modified in-place by the format command.
                    stdin = true,
                    -- A function that calculates the directory to run the command in
                    cwd = require("conform.util").root_file({ ".editorconfig" }),
                },
            },
        })
    end,
}
