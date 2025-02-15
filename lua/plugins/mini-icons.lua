return {
    "mini.icons",
    event = "DeferredUIEnter",
    after = function()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
    end,
}
