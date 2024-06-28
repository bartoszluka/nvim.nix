local current_buf = 0
local force = true
return {
    "mini.bufremove",
    -- stylua: ignore
    keys = {
        { "<leader>x", function() require("mini.bufremove").delete(current_buf, not force) end, desc = "delete buffer" },
        { "<leader>X", function() require("mini.bufremove").delete(current_buf, force) end,  desc = "delete buffer (force)" },
    },
}
