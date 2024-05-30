-- local signs = { Error = " ", Warn = "", Hint = "", Info = "" }
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

vim.opt.listchars = {
    space = "·",
    tab = "→ ",
    -- tab = " ",
    trail = "·",
    extends = "»",
    precedes = "«",
    -- nbsp = "░",
    nbsp = "␣",
}
vim.opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "›",
    vert = "▏",
}

nx.set({
    -- General
    clipboard = "unnamedplus", -- use system clipboard
    mouse = "a", -- allow mouse in all modes
    lazyredraw = true,
    showmode = false, -- print vim mode on enter
    termguicolors = true, -- set term gui colors
    timeoutlen = 350, -- time to wait for a mapped sequence to complete
    list = true, -- Show some invisible characters
    undofile = true, -- enable persistent undo
    backup = false, -- create a backup file
    swapfile = false, -- create a swap file
    -- Command line
    cmdheight = 1,
    -- Completion menu
    pumheight = 14, -- completion popup menu height
    shortmess__append = "c", -- don't give completion-menu messages
    -- Gutter
    number = true, -- show line numbers
    numberwidth = 3, -- number column width - default "4"
    relativenumber = true, -- set relative line numbers
    signcolumn = "yes:2", -- use fixed width signcolumn - prevents text shift when adding signs
    -- Search
    hlsearch = false, -- highlight matches in previous search pattern
    ignorecase = true, -- ignore case in search patterns
    smartcase = true, -- use smart case - ignore case UNLESS /C or capital in search
    -- folds
    foldmethod = "expr",
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
    foldtext = "v:lua.vim.treesitter.foldtext()",
    -- foldenable = false, --disable folds on start
    -- ...
    wrap = false, -- wrapping of text
    breakindent = true,
    updatetime = 250, -- decrease update time
    hidden = true, -- Enable background buffers
    joinspaces = false, -- No double spaces with join
    scrolloff = 10, -- Lines of context
    shiftwidth = 4, -- Size of an indent
    tabstop = 4, -- Size of an indent
    expandtab = true, -- Use spaces instead of tabs
    sidescrolloff = 20, -- Columns of context
    splitbelow = true, -- Put new windows below current
    splitright = true, -- Put new windows right of current
    completeopt = "menu,menuone,noinsert,preview", -- Set completeopt to have a better completion experience
    guicursor = "n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20",
    -- inccommand = "split",                          -- show the effects of a search / replace in a live preview window
    formatexpr = "v:lua.require'conform'.formatexpr()",
}, vim.opt)

function MyFoldtext()
    local foldtext = vim.treesitter.foldtext()

    ---@diagnostic disable-next-line: undefined-field
    local lines_folded = vim.v.foldend - vim.v.foldstart
    local text_lines = " lines"

    if lines_folded == 1 then
        text_lines = " line"
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    table.insert(foldtext, { " - " .. lines_folded .. text_lines, { "Folded" } })

    return foldtext
end

vim.opt.foldtext = "v:lua.MyFoldtext()"

nx.set({
    signcolumn = "yes",
    cursorline = true,
}, vim.wo)

nx.set({
    guifont = "FiraCode Nerd Font Mono:h9",
    -- guicursor = "n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20",
    showmode = false,
    laststatus = 3,
}, vim.go)

--  set border for floating windows
-- local border = {
--     { "🭽", "FloatBorder" },
--     { "▔", "FloatBorder" },
--     { "🭾", "FloatBorder" },
--     { "▕", "FloatBorder" },
--     { "🭿", "FloatBorder" },
--     { "▁", "FloatBorder" },
--     { "🭼", "FloatBorder" },
--     { "▏", "FloatBorder" },
-- }
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--     opts = opts or {}
--     opts.border = opts.border or border
--     return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

local function prefix_diagnostic(prefix, diagnostic)
    return string.format(prefix .. " %s", diagnostic.message)
end

vim.diagnostic.config({
    virtual_text = {
        prefix = "",
        format = function(diagnostic)
            local severity = diagnostic.severity
            if severity == vim.diagnostic.severity.ERROR then
                return prefix_diagnostic("󰅚", diagnostic)
            end
            if severity == vim.diagnostic.severity.WARN then
                return prefix_diagnostic("⚠", diagnostic)
            end
            if severity == vim.diagnostic.severity.INFO then
                return prefix_diagnostic("ⓘ", diagnostic)
            end
            if severity == vim.diagnostic.severity.HINT then
                return prefix_diagnostic("󰌶", diagnostic)
            end
            return prefix_diagnostic("■", diagnostic)
        end,
    },
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
    },
})
