return {
    "nord",
    colorscheme = "nord",
    after = function()
        require("nord").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            transparent = false, -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
            diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
            borders = true, -- Enable the border between verticaly split windows visible
            errors = { mode = "fg" }, -- Display mode for errors and diagnostics
            -- values : [bg|fg|none]
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = false },
                keywords = {},
                functions = {},
                variables = {},
            },
            colorblind = {
                enable = false,
            },
            --- You can override specific highlights to use other groups or a hex color
            --- function will be called with all highlights and the colorScheme table
            on_highlights = function(highlights, colors)
                highlights.DiffAdd.fg = "#002800"
                highlights.DiffAdd.bg = colors.snow_storm.brightest

                highlights.DiffDelete.fg = "#3f0001"
                highlights.DiffDelete.bg = colors.snow_storm.brightest
                -- highlights.MultiCursor = "#434c5e"
                -- highlights.MultiCursorMain.fg = colors.nord3
            end,
        })
    end,
}
