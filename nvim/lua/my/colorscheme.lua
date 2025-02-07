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

        -- colors = {
        --   aurora = {
        --     green = "#A3BE8C",
        --     orange = "#D08770",
        --     purple = "#B48EAD",
        --     red = "#BF616A",
        --     yellow = "#EBCB8B"
        --   },
        --   frost = {
        --     artic_ocean = "#5E81AC",
        --     artic_water = "#81A1C1",
        --     ice = "#88C0D0",
        --     polar_water = "#8FBCBB"
        --   },
        --   none = "NONE",
        --   polar_night = {
        --     bright = "#3B4252",
        --     brighter = "#434C5E",
        --     brightest = "#4C566A",
        --     light = "#616E88",
        --     origin = "#2E3440"
        --   },
        --   snow_storm = {
        --     brighter = "#E5E9F0",
        --     brightest = "#ECEFF4",
        --     origin = "#D8DEE9"
        --   }
        -- }
    end,
})

require("nord").load()
