-- Diagnostic keymaps
vim.diagnostic.config({ severity_sort = true })
nx.map({
    {
        "[e",
        function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "prev error",
    },
    {
        "]e",
        function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "next error",
    },
})

nx.map({
    { "L", "$", { "n", "v", "o" }, silent = true },
    { "H", "0", { "n", "v", "o" }, silent = true },
})

-- Remap for dealing with word wrap
nx.map({
    { "k", "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true },
    { "j", "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true },
})

-- local function close_all_floating_windows()
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--         local config = vim.api.nvim_win_get_config(win)
--         if config.relative ~= "" then
--             vim.api.nvim_win_close(win, false)
--         end
--     end
-- end

-- vim.on_key(function(char)
--     if vim.fn.mode() == "n" then
--         local is_search_key = vim.tbl_contains({ "n", "N", "*", "#", "/", "?" }, vim.fn.keytrans(char))
--         if is_search_key and (not vim.opt.hlsearch:get()) then
--             vim.opt.hlsearch = true
--         end
--     end
-- end)

-- nx.map({
--     "<Esc>",
--     function()
--         --  TODO: don't close toggleterm
--         close_all_floating_windows()
--         if vim.opt.hlsearch:get() then
--             vim.opt.hlsearch = false
--         end
--         -- return "<Esc>"
--     end,
--     mode = { "n" },
--     silent = true,
--     noremap = true,
-- })

nx.map({
    { "<leader>q", "<cmd>confirm quit<CR>", desc = "Quit" },
    { "<leader>u", "g~l",                   desc = "Swap case" },
    { "<leader>w", "<cmd>write<CR>",        desc = "Write file", silent = true },
    { "<leader>W", "<cmd>write<CR>",        desc = "Write file" },
})

local modes = { "n", "v", "t" }
nx.map({
    { "<C-j>", "<C-w>j", modes, desc = "Focus window to the bottom" },
    { "<C-k>", "<C-w>k", modes, desc = "Focus window to the top" },
    { "<C-l>", "<C-w>l", modes, desc = "Focus window to the right" },
    { "<C-h>", "<C-w>h", modes, desc = "Focus window to the left" },
})

nx.map({
    { ";",     ":",       { "n", "v" }, silent = false }, -- map ';' to start command mode
    { "<C-l>", "<Right>", { "c" },      silent = false },
})
