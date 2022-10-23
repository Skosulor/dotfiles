local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local finder_results = {
    "os",
    "subprocess",
    "math"
    }

-- our picker function: colors
local colors = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_table {
      results = finder_results
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        --print(vim.inspect(selection))
        --vim.api.nvim_put({ selection[1] }, "", false, true)
        vim.cmd("! pydoc3 " .. selection[1])
      end)
      return true
    end,
  }):find()
end

-- to execute the function
colors(require("telescope.themes").get_dropdown{})

-- Python sippet which prints python standard libs
--import distutils.sysconfig as sysconfig
--import os
--std_lib = sysconfig.get_python_lib(standard_lib=True)
--for top, dirs, files in os.walk(std_lib):
    --for nm in files:
        --if nm != '__init__.py' and nm[-3:] == '.py':
            --print os.path.join(top, nm)[len(std_lib)+1:-3].replace(os.sep, '.')
