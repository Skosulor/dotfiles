local M = {}

M.man_pages = function()
   local d = lua require'telescope.builtin'.man_pages{sections = {"ALL"}}
   return d
end

M.grep_project = function()
    local fname = vim.fn.input("Search: ", "", "file")
    vim.cmd('Ggrep -q ' .. fname)
end

return M
