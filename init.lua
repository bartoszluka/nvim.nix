vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

_G.nx = require("nx")
_G.cmd = function(command)
    return "<cmd>" .. command .. "<CR>"
end

vim.g.editorconfig = true

require("my.colorscheme")
require("my.oil")
require("my.autocommands")
require("my.settings")
require("my.keymaps")
require("my.commands")

require("lze").load("plugins")
-- require("lz.n").load("plugins")
