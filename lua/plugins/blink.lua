return {
    "blink-cmp",
    event = { "InsertEnter", "CmdlineEnter" },

    after = function()
        local setup = require("blink.cmp")().setup
        -- require("blink.cmp").setup({
        setup({
            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                -- nerd_font_variant = "mono",
            },
            fuzzy = { prebuilt_binaries = { download = false } },
            keymap = {
                preset = "default",
                -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                -- ["<C-e>"] = { "hide" },
                -- ["<C-y>"] = { "select_and_accept" },
                --
                -- ["<C-p>"] = { "select_prev", "fallback" },
                -- ["<C-n>"] = { "select_next", "fallback" },
                --
                -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                --
                -- ["<C-l>"] = { "snippet_forward", "fallback" },
                -- ["<C-h>"] = { "snippet_backward", "fallback" },
            },
            completion = {
                accept = {
                    -- Create an undo point when accepting a completion item
                    create_undo_point = true,
                    -- How long to wait for the LSP to resolve the item with additional information before continuing as-is
                    resolve_timeout_ms = 100,
                    -- Experimental auto-brackets support
                    auto_brackets = {
                        -- Whether to auto-insert brackets for functions
                        enabled = true,
                        -- Default brackets to use for unknown languages
                        default_brackets = { "(", ")" },
                        -- Overrides the default blocked filetypes
                        override_brackets_for_filetypes = {},
                        -- Synchronously use the kind of the item to determine if brackets should be added
                        kind_resolution = {
                            enabled = true,
                            blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
                        },
                        -- Asynchronously use semantic token to determine if brackets should be added
                        semantic_token_resolution = {
                            enabled = true,
                            blocked_filetypes = { "java" },
                            -- How long to wait for semantic tokens to return before assuming no brackets should be added
                            timeout_ms = 400,
                        },
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
        })
    end,
}
