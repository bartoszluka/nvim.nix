return {
    "markdown-preview.nvim",
    -- NOTE: for_cat is a custom handler that just sets enabled value for us,
    -- based on result of nixCats('cat.name') and allows us to set a different default if we wish
    -- it is defined in luaUtils template in lua/nixCatsUtils/lzUtils.lua
    -- you could replace this with enabled = nixCats('cat.name') == true
    -- if you didnt care to set a different default for when not using nix than the default you already set
    -- for_cat = "general.markdown",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = "markdown",
    keys = {
        { "<leader>mp", cmd("MarkdownPreview"), mode = { "n" }, noremap = true, desc = "markdown preview" },
        {
            "<leader>ms",
            cmd("MarkdownPreviewStop"),
            mode = { "n" },
            noremap = true,
            desc = "markdown preview stop",
        },
        {
            "<leader>mt",
            cmd("MarkdownPreviewToggle"),
            mode = { "n" },
            noremap = true,
            desc = "markdown preview toggle",
        },
    },
    before = function()
        vim.g.mkdp_auto_close = 0
    end,
}
