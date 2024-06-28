vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

_G.nx = require("nx")
_G.cmd = function(command)
    return "<cmd>" .. command .. "<CR>"
end

vim.g.editorconfig = true

-- Native plugins
-- cmd.filetype("plugin", "indent", "on")
-- cmd.packadd("cfilter") -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require("luv").os_getenv("LIBSQLITE")

require("lz.n").load("plugins")
require("my.autocommands")
require("my.settings")
require("my.keymaps")
require("my.commands")
