
-- If workspace is a git directory, search git files otherwise search files
local M = {}
M.project_files = function()
  local opts = {} -- define options here if you want to set something

  -- Function to check if the current directory is part of a git repository
  local function is_git_repo()
    local handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
    local result = handle:read('*a')
    handle:close()
    return result:match('true') ~= nil
  end

  if is_git_repo() then
      Snacks.picker.git_files(opts)
  else
      Snacks.picker.files(opts)
  end
end
M.herp = function()
    print("derp")
end

M.checkout_blob = function()
    local snacks = require'Snacks'

    -- Step 1: Pick a Git revision (branches + commits)
    snacks.define('git_revision', {
        command = "git branch --format='%(refname:short)' && git log --pretty=format:'%h %s' --no-merges",
        action = function(entry)
            local revision = entry[1]:match("^(%S+)") -- Extracts the commit hash or branch name
            snacks.run('git_blob', { revision })
        end
    })

    -- Step 2: Pick a file from the selected revision
    snacks.define('git_blob', {
        command = function(args)
            local revision = args[1]
            return "git ls-tree -r --name-only " .. revision
        end,
        action = function(entry, args)
            local revision = args[1]
            local filepath = entry[1]
            vim.cmd("new") -- Open in a new buffer
            vim.cmd("read !git show " .. revision .. ":" .. filepath) -- Load file contents
            vim.cmd("normal! gg") -- Move to top of file
        end
    })
end
return M




