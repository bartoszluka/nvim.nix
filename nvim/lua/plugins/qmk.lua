return {
    "qmk",
    ft = "c",
    after = function()
        ---@type qmk.UserConfig
        local conf = {
            name = "LAYOUT",
            layout = {
                "x x x x x x _ _ _ _ _ x x x x x x",
                "x x x x x x _ _ _ _ _ x x x x x x",
                "x x x x x x x x _ x x x x x x x x",
                "_ _ _ x x x x x _ x x x x x _ _ _",
            },
            comment_preview = {
                keymap_overrides = {
                    ["MT%(MOD_LALT, KC_TAB%)"] = "alt/tab",
                    ["MT%(MOD_LSFT, KC_BSPC%)"] = "lsft/bspc",
                    ["MT%(MOD_LCTL, KC_ESC%)"] = "lctl/esc",
                    ["LT%(_FANDMEDIA, KC_ENT%)"] = "fn/entr",
                    ["LT%(_SYMBOLS, KC_SPC%)"] = "symb/spc",
                    ["OSM%(MOD_RALT%)"] = "ralt",
                    ["LCTL%(KC_C%)"] = "ctrl+c",
                    ["LCTL%(KC_V%)"] = "ctrl+v",
                    ["LCTL%(KC_X%)"] = "ctrl+x",
                    ["LALT%(KC_F10%)"] = "alt+f10",
                    ["LCTL%(KC_6%)"] = "ctrl+6",
                },
            },
        }
        require("qmk").setup(conf)
    end,
}
