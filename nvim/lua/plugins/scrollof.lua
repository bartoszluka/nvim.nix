return {
    "scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    after = function()
        require("scrollEOF").setup()
    end,
}
