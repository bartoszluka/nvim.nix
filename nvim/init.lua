local cmd = vim.cmd
local opt = vim.o
local g = vim.g

-- <leader> key. Defaults to `\`. Some people prefer space.
g.mapleader = " "
g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

_G.nx = require("nx")

-- Search down into subfolders
opt.path = vim.o.path .. "**"

-- Configure Neovim diagnostic messages

g.editorconfig = true

-- Native plugins
cmd.filetype("plugin", "indent", "on")
cmd.packadd("cfilter") -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require("luv").os_getenv("LIBSQLITE")
