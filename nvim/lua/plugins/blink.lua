return {
    "blink.cmp",
    event = "DeferredUIEnter",
    enabled = false,
    after = function()
        require("blink.cmp").setup({
            highlight = {
                -- sets the fallback highlight groups to nvim-cmp's highlight groups
                -- useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release, assuming themes add support
                use_nvim_cmp_as_default = true,
            },
            nerd_font_variant = "normal",
            accept = { auto_brackets = { enabled = true } },
            opts_extend = { "sources.completion.enabled_providers" },
            keymap = {
                -- "default" keymap
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide" },
                ["<C-y>"] = { "select_and_accept" },

                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
            fuzzy = { prebuilt_binaries = { download = false } },
        })
    end,
}
