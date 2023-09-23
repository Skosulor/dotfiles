local M = {}

M.man_pages = function()
   local d = lua require'telescope.builtin'.man_pages{sections = {"ALL"}}
   return d
end

M.grep_project = function()
    local fname = vim.fn.input("Search: ", "", "file")
    vim.cmd('grep! ' .. fname)
    vim.cmd('copen')
end

M.toggle_qf = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end

return M
