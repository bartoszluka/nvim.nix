return {
    "eyeliner",
    keys = { "f", "F", "t", "T" },
    event = "DeferredUIEnter",
    after = function()
        require("eyeliner").setup({
            highlight_on_key = true, -- show highlights only after key press
            dim = true, -- dim all other characters
        })
    end,
}
