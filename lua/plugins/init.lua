return {
    { import = "plugins.telescope" },
    { import = "plugins.treesitter" },
    { import = "plugins.lspconfig" },
    -- { import = "plugins.completion" },
    {
        "lazydev.nvim",
        -- for_cat = "neonixdev",
        cmd = { "LazyDev" },
        ft = "lua",
        after = function(plugin)
            require("lazydev").setup({
                library = {
                    { words = { "nixCats" }, path = (require("nixCats").nixCatsPath or "") .. "/lua" },
                },
            })
        end,
    },
    {
        "markdown-preview.nvim",
        -- NOTE: for_cat is a custom handler that just sets enabled value for us,
        -- based on result of nixCats('cat.name') and allows us to set a different default if we wish
        -- it is defined in luaUtils template in lua/nixCatsUtils/lzUtils.lua
        -- you could replace this with enabled = nixCats('cat.name') == true
        -- if you didnt care to set a different default for when not using nix than the default you already set
        -- for_cat = "general.markdown",
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
        ft = "markdown",
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreview <CR>", mode = { "n" }, noremap = true, desc = "markdown preview" },
            {
                "<leader>ms",
                "<cmd>MarkdownPreviewStop <CR>",
                mode = { "n" },
                noremap = true,
                desc = "markdown preview stop",
            },
            {
                "<leader>mt",
                "<cmd>MarkdownPreviewToggle <CR>",
                mode = { "n" },
                noremap = true,
                desc = "markdown preview toggle",
            },
        },
        before = function(plugin)
            vim.g.mkdp_auto_close = 0
        end,
    },
    -- {
    --     "undotree",
    --     -- for_cat = "general.extra",
    --     cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotreePersistUndo" },
    --     keys = { { "<leader>U", "<cmd>UndotreeToggle<CR>", mode = { "n" }, desc = "Undo Tree" } },
    --     before = function(_)
    --         vim.g.undotree_WindowLayout = 1
    --         vim.g.undotree_SplitWidth = 40
    --     end,
    -- },
    -- {
    --     "indent-blankline.nvim",
    --     for_cat = "general.extra",
    --     event = "DeferredUIEnter",
    --     after = function(plugin)
    --         require("ibl").setup()
    --     end,
    -- },
    {
        "nvim-surround",
        -- for_cat = "general.always",
        event = "DeferredUIEnter",
        -- keys = "",
        after = function(plugin)
            require("nvim-surround").setup({
                keymaps = {
                    visual = "s",
                },
                highlight = { duration = 200 },
                aliases = {
                    ["q"] = { '"', "'", "`" },
                    ["s"] = {
                        "{",
                        "[",
                        "(",
                        "<",
                        '"',
                        "'",
                        "`",
                    },
                    ["b"] = ")",
                    ["r"] = "]",
                    ["B"] = "}",
                },
                surrounds = {
                    -- -- TODO: do this just for lua
                    -- f = {
                    --     add = { "function() ", " end" },
                    --     delete = get_function_definition_range,
                    --     change = {
                    --         target = get_function_definition_range,
                    --         replacement = function()
                    --             local config = require("nvim-surround.config")
                    --             local input = require("nvim-surround.input")
                    --             local ins_char = input.get_char()
                    --             local delimiters = config.get_delimiters(ins_char, false)
                    --             return delimiters
                    --         end,
                    --     },
                    -- },
                    q = { add = { '"', '"' } },
                },
                indent_lines = false,
                move_cursor = false,
            })
        end,
    },
    {
        "vim-startuptime",
        -- for_cat = "general.extra",
        cmd = { "StartupTime" },
        before = function(_)
            vim.g.startuptime_event_width = 0
            vim.g.startuptime_tries = 10
            vim.g.startuptime_exe_path = nixCats.packageBinPath
        end,
    },
    {
        "fidget.nvim",
        -- for_cat = "general.extra",
        event = "LspAttach",
        -- keys = "",
        after = function(plugin)
            require("fidget").setup({})
        end,
    },
    -- {
    --   "hlargs",
    --   for_cat = 'general.extra',
    --   event = "DeferredUIEnter",
    --   -- keys = "",
    --   dep_of = { "nvim-lspconfig" },
    --   after = function(plugin)
    --     require('hlargs').setup {
    --       color = '#32a88f',
    --     }
    --     vim.cmd([[hi clear @lsp.type.parameter]])
    --     vim.cmd([[hi link @lsp.type.parameter Hlargs]])
    --   end,
    -- },
    {
        "lualine.nvim",
        event = "DeferredUIEnter",
        after = function(plugin)
            local function lsp()
                local buf_id = vim.api.nvim_get_current_buf()
                local lsps = vim.lsp.get_clients({ bufnr = buf_id })
                local lsp_names = vim.iter(lsps)
                    :map(function(server)
                        return server.name
                    end)
                    :join("+")
                return lsp_names
            end
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "nord",
                    component_separators = "|",
                    section_separators = "",
                },
                sections = {
                    lualine_a = {
                        "mode",
                    },
                    lualine_b = {
                        "branch",
                    },
                    lualine_c = {
                        {
                            "filename",
                            file_status = true, -- Displays file status (readonly status, modified status)
                            newfile_status = true, -- Display new file status (new file means no write after created)
                            path = 4,
                            -- 0: Just the filename
                            -- 1: Relative path
                            -- 2: Absolute path
                            -- 3: Absolute path, with tilde as the home directory
                            -- 4: Filename and parent dir, with tilde as the home directory
                        },
                    },
                    lualine_x = {
                        lsp,
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            colored = true,
                        },
                    },
                    lualine_y = {
                        -- "fileformat",
                        "filetype",
                        "encoding",
                    },
                    lualine_z = {
                        {
                            "location",
                            "selectioncount",
                        },
                    },
                },
                inactive_sections = {
                    lualine_b = {
                        {
                            "filename",
                            path = 0,
                            status = true,
                        },
                    },
                    lualine_x = { "filetype" },
                },
                tabline = {},
                extensions = {
                    "quickfix",
                    "oil",
                    "toggleterm",
                },
            })
        end,
    },
    {
        "gitsigns.nvim",
        event = "DeferredUIEnter",
        after = function(plugin)
            require("gitsigns").setup({
                -- See `:help gitsigns.txt`
                current_line_blame = false,
                current_line_blame_opts = {
                    ignore_whitespace = true,
                },
                -- signs = {
                --     add = { text = "+" },
                --     change = { text = "~" },
                --     delete = { text = "_" },
                --     topdelete = { text = "‾" },
                --     changedelete = { text = "~" },
                -- },
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signs_staged = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signs_staged_enable = true,

                word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]h", function()
                        if vim.wo.diff then
                            return "]g"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "git next hunk" })

                    map("n", "[h", function()
                        if vim.wo.diff then
                            return "[g"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, desc = "git previous hunk" })

                    -- Actions
                    map("v", "<leader>hs", function()
                        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "git hunk stage" })
                    map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })

                    map("v", "<leader>hr", function()
                        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "reset hunk git" })
                    map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })

                    map("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
                    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
                    map("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
                    map("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
                    map("n", "<leader>hb", function()
                        gs.blame_line({ full = false })
                    end, { desc = "git blame line" })
                    map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end, { desc = "git diff against last commit" })

                    -- Toggles
                    map("n", "<leader>glb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
                    map("n", "<leader>gtd", gs.toggle_deleted, { desc = "toggle git show deleted" })

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
                end,
            })
        end,
    },
    {
        "neogit",
        cmd = { "Neogit", "NeogitLog", "NeogitCommit" },
        keys = { { "<leader>gg", cmd("Neogit") } },
        after = function()
            require("neogit").setup({
                graph_style = "unicode",
                git_services = {
                    ["netcompany.com"] = "https://source.netcompany.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
                },

                telescope_sorter = function()
                    return require("telescope").extensions.fzy_native.native_fzy_sorter()
                end,

                initial_branch_name = "feature/",
                kind = "auto",
                integrations = { telescope = true },
                commit_editor = {
                    ["<c-p>"] = "PrevMessage",
                    ["<c-n>"] = "NextMessage",
                    ["<c-e>"] = "Abort",
                },
            })
        end,
    },
    {
        "which-key.nvim",
        event = "DeferredUIEnter",
        after = function(plugin)
            require("which-key").setup({
                ---@type false | "classic" | "modern" | "helix"
                preset = "helix",
                -- Delay before showing the popup. Can be a number or a function that returns a number.
                ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
                -- delay = function(ctx)
                --     return ctx.plugin and 0 or 500
                -- end,
                delay = 500,
                ---@param mapping wk.Mapping
                filter = function(mapping)
                    -- example to exclude mappings without a description
                    -- return mapping.desc and mapping.desc ~= ""
                    return true
                end,
                --- You can add any mappings here, or use `require('which-key').add()` later
                ---@type wk.Spec
                spec = {},
                -- show a warning when issues were detected with your mappings
                notify = false,
                -- Which-key automatically sets up triggers for your mappings.
                -- But you can disable this and setup the triggers manually.
                -- Check the docs for more info.
                ---@type wk.Spec

                -- triggers = {
                --     { "<auto>", mode = "nixsotc" },
                -- },

                -- Start hidden and wait for a key to be pressed before showing the popup
                -- Only used by enabled xo mapping modes.
                ---@param ctx { mode: string, operator: string }
                defer = function(ctx)
                    return ctx.mode == "V" or ctx.mode == "<C-V>"
                end,
                plugins = {
                    marks = true, -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                    -- No actual key bindings are created
                    spelling = {
                        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 20, -- how many suggestions should be shown in the list?
                    },
                    presets = {
                        operators = true, -- adds help for operators like d, y, ...
                        motions = true, -- adds help for motions
                        text_objects = true, -- help for text objects triggered after entering an operator
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = false, -- bindings for prefixed with g
                    },
                },
                ---@type wk.Win.opts
                win = {
                    -- don't allow the popup to overlap with the cursor
                    no_overlap = true,
                    -- width = 1,
                    -- height = { min = 4, max = 25 },
                    -- col = 0,
                    -- row = math.huge,
                    -- border = "none",
                    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
                    title = true,
                    title_pos = "center",
                    zindex = 1000,
                    -- Additional vim.wo and vim.bo options
                    bo = {},
                    wo = {
                        -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                    },
                },
                layout = {
                    width = { min = 20 }, -- min and max width of the columns
                    spacing = 3, -- spacing between columns
                },
                keys = {
                    scroll_down = "<c-d>", -- binding to scroll down inside the popup
                    scroll_up = "<c-u>", -- binding to scroll up inside the popup
                },
                ---@type (string|wk.Sorter)[]
                --- Mappings are sorted using configured sorters and natural sort of the keys
                --- Available sorters:
                --- * local: buffer-local mappings first
                --- * order: order of the items (Used by plugins like marks / registers)
                --- * group: groups last
                --- * alphanum: alpha-numerical first
                --- * mod: special modifier keys last
                --- * manual: the order the mappings were added
                --- * case: lower-case first
                sort = { "local", "order", "group", "alphanum", "mod" },
                ---@type number|fun(node: wk.Node):boolean?
                expand = 0, -- expand groups when <= n mappings
                -- expand = function(node)
                --   return not node.desc -- expand all nodes without a description
                -- end,
                -- Functions/Lua Patterns for formatting the labels
                ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
                replace = {
                    key = {
                        function(key)
                            return require("which-key.view").format(key)
                        end,
                        -- { "<Space>", "SPC" },
                    },
                    desc = {
                        { "<Plug>%(?(.*)%)?", "%1" },
                        { "^%+", "" },
                        { "<[cC]md>", "" },
                        { "<[cC][rR]>", "" },
                        { "<[sS]ilent>", "" },
                        { "^lua%s+", "" },
                        { "^call%s+", "" },
                        { "^:%s*", "" },
                    },
                },
                icons = {
                    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                    separator = "➜", -- symbol used between a key and it's label
                    group = "+", -- symbol prepended to a group
                    ellipsis = "…",
                    -- set to false to disable all mapping icons,
                    -- both those explicitely added in a mapping
                    -- and those from rules
                    mappings = true,
                    --- See `lua/which-key/icons.lua` for more details
                    --- Set to `false` to disable keymap icons from rules
                    ---@type wk.IconRule[]|false
                    rules = {},
                    -- use the highlights from mini.icons
                    -- When `false`, it will use `WhichKeyIcon` instead
                    colors = true,
                    -- used by key format
                    keys = {
                        Up = " ",
                        Down = " ",
                        Left = " ",
                        Right = " ",
                        C = "󰘴 ",
                        M = "󰘵 ",
                        D = "󰘳 ",
                        S = "󰘶 ",
                        CR = "󰌑 ",
                        Esc = "󱊷 ",
                        ScrollWheelDown = "󱕐 ",
                        ScrollWheelUp = "󱕑 ",
                        NL = "󰌑 ",
                        BS = "󰁮",
                        Space = "󱁐 ",
                        Tab = "󰌒 ",
                        F1 = "󱊫",
                        F2 = "󱊬",
                        F3 = "󱊭",
                        F4 = "󱊮",
                        F5 = "󱊯",
                        F6 = "󱊰",
                        F7 = "󱊱",
                        F8 = "󱊲",
                        F9 = "󱊳",
                        F10 = "󱊴",
                        F11 = "󱊵",
                        F12 = "󱊶",
                    },
                },
                show_help = true, -- show a help message in the command line for using WhichKey
                show_keys = true, -- show the currently pressed key and its label as a message in the command line
                -- disable WhichKey for certain buf types and file types.
                disable = {
                    ft = {},
                    bt = {},
                },
                debug = false, -- enable wk.log in the current directory
            })
        end,
    },
    {
        "blink.cmp",
        event = { "InsertEnter", "CmdlineEnter" },

        after = function()
            require("blink.cmp").setup({
                appearance = {
                    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                    -- Useful for when your theme doesn't support blink.cmp
                    -- Will be removed in a future release
                    use_nvim_cmp_as_default = true,
                    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    -- nerd_font_variant = "mono",
                },
                fuzzy = { prebuilt_binaries = { download = false } },
                keymap = {
                    preset = "default",
                    -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                    -- ["<C-e>"] = { "hide" },
                    -- ["<C-y>"] = { "select_and_accept" },
                    --
                    -- ["<C-p>"] = { "select_prev", "fallback" },
                    -- ["<C-n>"] = { "select_next", "fallback" },
                    --
                    -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                    -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                    --
                    -- ["<C-l>"] = { "snippet_forward", "fallback" },
                    -- ["<C-h>"] = { "snippet_backward", "fallback" },
                },
                completion = {
                    accept = {
                        -- Create an undo point when accepting a completion item
                        create_undo_point = true,
                        -- How long to wait for the LSP to resolve the item with additional information before continuing as-is
                        resolve_timeout_ms = 100,
                        -- Experimental auto-brackets support
                        auto_brackets = {
                            -- Whether to auto-insert brackets for functions
                            enabled = true,
                            -- Default brackets to use for unknown languages
                            default_brackets = { "(", ")" },
                            -- Overrides the default blocked filetypes
                            override_brackets_for_filetypes = {},
                            -- Synchronously use the kind of the item to determine if brackets should be added
                            kind_resolution = {
                                enabled = true,
                                blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
                            },
                            -- Asynchronously use semantic token to determine if brackets should be added
                            semantic_token_resolution = {
                                enabled = true,
                                blocked_filetypes = { "java" },
                                -- How long to wait for semantic tokens to return before assuming no brackets should be added
                                timeout_ms = 400,
                            },
                        },
                    },
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
            })
        end,
    },
    {
        "bufonly",
        keys = { { "<leader>bo", "<cmd>BufOnly<CR>", desc = "remove all buffers but this one" } },
        cmd = "BufOnly",
    },
    {
        "nvim-colorizer.lua",
        -- event = "DeferredUIEnter",
        ft = { "nix", "css", "html", "haskell", "lua", "elm" },
        after = function()
            require("colorizer").setup({
                filetypes = { "nix", "css", "html", "haskell", "lua", "elm" },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = false, -- "Name" codes like Blue or blue
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    AARRGGBB = false, -- 0xAARRGGBB hex codes
                    rgb_fn = true, -- CSS rgb() and rgba() functions
                    hsl_fn = true, -- CSS hsl() and hsla() functions
                    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = "virtualtext", -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = false, -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
                    virtualtext = "■",
                    -- update color values even if buffer is not focused
                    -- example use: cmp_menu, cmp_docs
                    always_update = false,
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {},
            })
        end,
    },
    {
        "conform.nvim",
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({
                        async = true,
                        lsp_fallback = true,
                    })
                end,
                desc = "format file",
            },
        },
        after = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "isort", "ruff_format" },
                    -- Use a sub-list to run only the first available formatter
                    javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
                    yaml = { "prettierd", "prettier", stop_after_first = true },
                    json = { "biome", "prettierd", "prettier", stop_after_first = true },
                    css = { "prettierd", "prettier", stop_after_first = true },
                    fish = { "fish_indent" },
                    xml = { "xq" },
                    sh = { "shfmt" },
                    c = { "clang_format" },
                    cs = { "csharpier" },
                    fsharp = { "fantomas" },
                    markdown = { "mdslw", "mdformat", "markdown-toc" },
                    nix = { "alejandra" },
                    haskell = { "fourmolu" },
                    tex = { "latexindent", "trim_whitespace" },
                    -- ["*"] = { "codespell" },
                    -- ["_"] = { "trim_whitespace" },
                },

                formatters = {
                    biome = {
                        command = "biome",
                        stdin = true,
                        args = { "format", "--indent-style=space", "--stdin-file-path", "$FILENAME" },
                        cwd = require("conform.util").root_file({ ".editorconfig" }),
                    },
                    fourmolu = {
                        range_args = function(ctx)
                            return { "--start-line", ctx.range.start[1], "--end-line", ctx.range["end"][1] }
                        end,
                    },
                    alejandra = {
                        command = "alejandra",
                        args = { "-qq" },
                        stdin = true,
                    },
                    mdslw = {
                        prepend_args = { "--max-width", "110" },
                    },
                    fantomas = {
                        command = "fantomas",
                        args = { "$FILENAME" },
                        stdin = false,
                    },
                    xq = {
                        -- This can be a string or a function that returns a string.
                        -- When defining a new formatter, this is the only field that is *required*
                        command = "xq",
                        -- A list of strings, or a function that returns a list of strings
                        -- Return a single string instead of a list to run the command in a shell
                        args = { "--indent", "4" },

                        -- Send file contents to stdin, read new contents from stdout (default true)
                        -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
                        -- file is assumed to be modified in-place by the format command.
                        stdin = true,
                        -- A function that calculates the directory to run the command in
                        cwd = require("conform.util").root_file({ ".editorconfig" }),
                    },
                },
            })
        end,
    },
    {
        "guess-indent.nvim",
        event = { "BufReadPost", "BufWinEnter" },
        cmd = { "GuessIndent" },
        after = function()
            -- This is the default configuration
            require("guess-indent").setup({
                auto_cmd = true, -- Set to false to disable automatic execution
                override_editorconfig = false, -- Set to true to override settings set by .editorconfig
                filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
                    "netrw",
                    "tutor",
                },
                buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
                    "help",
                    "nofile",
                    "terminal",
                    "prompt",
                },
                on_tab_options = { -- A table of vim options when tabs are detected
                    ["expandtab"] = false,
                },
                on_space_options = { -- A table of vim options when spaces are detected
                    ["expandtab"] = true,
                    ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
                    ["softtabstop"] = "detected",
                    ["shiftwidth"] = "detected",
                },
            })
        end,
    },
    {
        "mini.icons",
        event = "DeferredUIEnter",
        after = function()
            require("mini.icons").setup()
            MiniIcons.mock_nvim_web_devicons()
        end,
    },
    {
        "mini.ai",
        event = { "BufReadPost", "BufNewFile" },
        after = function()
            local ai = require("mini.ai")
            ai.setup({
                n_lines = 500,
                custom_textobjects = {
                    -- Disable brackets alias in favor of builtin block textobject
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = false,
                    -- f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = false,
                    -- c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    b = false,
                    r = ai.gen_spec.pair("[", "]", { type = "balanced" }),
                    -- Whole buffer
                    e = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line("$"),
                            col = math.max(vim.fn.getline("$"):len(), 1),
                        }
                        return { from = from, to = to }
                    end,
                },
            })
        end,
    },
    {
        "mini.bufremove",
        keys = {
            {
                "<leader>x",
                function()
                    require("mini.bufremove").delete(0, false)
                end,
                desc = "delete buffer",
            },
            {
                "<leader>X",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "delete buffer (force)",
            },
        },
    },
    {
        "no-neck-pain.nvim",
        keys = {
            { "<leader>c", "<cmd>NoNeckPain<CR>", desc = "center view" },
        },
        after = function()
            require("no-neck-pain").setup({

                width = 120,
                buffers = { colors = { blend = -0.2 } },
            })
        end,
    },
    {
        "scrollEof",
        event = { "CursorMoved", "WinScrolled" },
        after = function()
            require("scrollEOF").setup()
        end,
    },
    {
        "ts-comments.nvim",
        event = "DeferredUIEnter",
        after = function()
            require("ts-comments").setup()
        end,
    },
    {
        "nvim-bqf",
        ft = "qf",
        after = function()
            require("bqf").setup({
                auto_resize_height = true,
                preview = {
                    winblend = 0,
                },
            })
        end,
    },
}
