
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
    require'fzf-lua'.git_files(opts)
  else
    require'fzf-lua'.files(opts)
  end
end
M.herp = function()
    print("derp")
end
return M




