local function get_git_branch_name()
    local process = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }):wait()
    local branch = vim.trim(process.stdout) or "main"
    return branch:gsub("/", "_")
end

local function get_session_name()
    local dir = vim.fs.normalize(vim.fn.getcwd()):gsub(":?/", "_")
    local ok, branch = pcall(get_git_branch_name)
    if ok then
        return dir .. "__" .. branch
    else
        return dir
    end
end

require("mini.sessions").setup({
    -- Whether to read default session if Neovim opened without file arguments
    autoread = false,

    -- Whether to write currently read session before quitting Neovim
    autowrite = false,

    -- Directory where global sessions are stored (use `''` to disable)
    -- directory = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "session"), --<"session" subdir of user data directory from |stdpath()|>,

    -- File for local session (use `''` to disable)
    file = "",

    -- Whether to force possibly harmful actions (meaning depends on function)
    force = { read = false, write = true, delete = false },

    -- Hook functions for actions. Default `nil` means 'do nothing'.
    hooks = {
        -- Before successful action
        pre = { read = nil, write = nil, delete = nil },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
    },

    -- Whether to print session path after action
    verbose = { read = false, write = false, delete = true },
})

nx.au({
    {
        "VimEnter",
        callback = function()
            local session_name = get_session_name()
            local all_sessions = vim.tbl_keys(MiniSessions.detected)
            if vim.tbl_contains(all_sessions, session_name) then
                MiniSessions.read(session_name)
            end
        end,
    },
    {
        "VimLeave",
        callback = function()
            local session_name = get_session_name()
            MiniSessions.write(session_name)
        end,
    },
}, {
    nested = true,
    once = true,
    create_group = "MySessions",
})
