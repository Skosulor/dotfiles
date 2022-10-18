local M = {}

M.man_pages = function()
   local d = lua require'telescope.builtin'.man_pages{sections = {"ALL"}}
   return d
end

return M
