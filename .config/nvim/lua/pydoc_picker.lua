local M = {}
-- our picker function: pydoc
M.pydoc = function(opts)

    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"


    local function mysplit (inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
        end
        return t
    end

    local cmd = ("python3 get_module_names.py")
    local f = assert(io.popen(cmd, 'r'))
    local results = assert(f:read('*a'))
    local finder_results = mysplit(results, "\n")


    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "pydoc",
        finder = finders.new_table {
            results = finder_results
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd("! pydoc3 " .. selection[1])
            end)
            return true
        end,
    }):find()
end

return M
--pydoc()
--pydoc(require("telescope.themes").get_ivy{})
