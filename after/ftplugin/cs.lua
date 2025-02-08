local function find_project_file(extension)
    local found_files = vim.fs.find(function(name, path)
        return vim.endswith(name, extension)
    end, {
        upward = true,
        limit = math.huge,
        type = "file",
        path = vim.fs.dirname(vim.fn.expand("%")),
    })

    if #found_files == 0 then
        vim.notify(string.format("no %s file found", extension), vim.log.levels.ERROR)

        return nil
    end
    local chosen_file = found_files[1]
    if #found_files > 1 then
        local prompt = string.format("multiple %s files found, choose one to continue", extension)
        vim.ui.select(found_files, { prompt = prompt }, function(choice)
            if choice == nil then
                vim.notify("no file was chosen", vim.log.levels.ERROR)
                return
            end

            chosen_file = choice
        end)
    end
    return chosen_file
end

local function build_and_set_qf(project_file)
    if vim.fn.executable("dotnet") == 0 then
        vim.notify("couldn't find executable `dotnet` in PATH", vim.log.levels.ERROR)
        return
    end
    local cmd = { "dotnet", "build", project_file, "--property:consoleLoggerParameter=ErrorsOnly" }
    vim.notify("building " .. project_file, vim.log.levels.INFO)
    vim.system(cmd, { text = true }, function(out)
        if out.code == 0 then
            vim.notify("no build errors", vim.log.levels.INFO)
            return
        end
        local lines = vim.split(out.stdout, "\n", { plain = true, trimempty = true })

        local qf_items = vim.iter(lines)
            :map(function(line)
                local path, line_num, col_num, msg = line:match("^(.+)%((%d+),(%d+)%)%: error (.+)$")

                if path and line_num and col_num and msg then
                    ---@diagnostic disable-next-line: unused-local
                    local error_code, actual_msg, project = msg:match("^(.+%:%s)(.+)%s(%[.+%])")
                    return {
                        filename = path,
                        lnum = tonumber(line_num),
                        col = tonumber(col_num),
                        text = actual_msg,
                    }
                else
                    return nil
                end
            end)
            :filter(function(thing)
                return thing ~= nil
            end)
            :totable()
        if #qf_items > 1 then
            local replace_items = "r"
            vim.schedule(function()
                vim.fn.setqflist(qf_items, replace_items)
                vim.cmd.copen()
            end)
        end
    end)
end

nx.cmd({
    "DotnetBuildSln",
    function()
        local project_file = find_project_file("sln")
        if project_file == nil then
            return
        end

        build_and_set_qf(project_file)
    end,
})

nx.cmd({
    "DotnetBuildCsproj",
    function()
        local project_file = find_project_file("csproj")
        if project_file == nil then
            return
        end

        build_and_set_qf(project_file)
    end,
})
