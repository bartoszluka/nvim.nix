local snap = require("snap")
local file_finder =
    snap.config.file({ producer = "git.file", consumer = "fzy", preview = true, preview_min_width = 60 })
snap.maps({
    { "<Leader><Leader>", file_finder },
    -- { "<Leader>ss",       snap.config.file { producer = "vim.buffer" } },
    -- { "<Leader>fo",       snap.config.file { producer = "vim.oldfile" } },
    -- { "<Leader>ff",       snap.config.vimgrep {} },
})
