return {
    "scrollEof",
    event = { "CursorMoved", "WinScrolled" },
    after = function()
        require("scrollEOF").setup()
    end,
}
