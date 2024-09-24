
local keymap = function(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"quickfix",},
    callback = function ()
        vim.api.nvim_buf_set_keymap(0,'n', '<C-j>',':colder<cr>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0,'n', '<C-k>',':cnew<cr>', { noremap = true, silent = true })
    end
})

-- Non leader key bindings
keymap('n', 'gr', '<nop>')
keymap('n', 'gr', '<cmd>FzfLua lsp_references<cr>')
keymap('x', '<leader>ch', ':ClangdSwitchSourceHeader<cr>')

-- Tabs
keymap('n', '<C-n>', '<CMD>tab new<cr><CMD>lua MiniStarter.open()<cr>', { noremap = true, silent = true })
keymap('t', '<C-n>', '<CMD>tab new<cr>', { noremap = true, silent = true })
keymap('n', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })
keymap('t', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })

 -- LSP
keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>')
keymap('n', 'gl', ':lua vim.diagnostic.open_float()<cr>')
keymap('n', 'K', ':lua vim.lsp.buf.hover()<enter>')

 -- Terminal
keymap('n', '<leader><tab>', '<cmd>ToggleTerm<cr>')
keymap('t', '<leader><tab>', "<C-\\><C-n><cmd>ToggleTerm<cr>", { noremap = true, silent = true })

-- Remove search highlihgt with ESC
keymap('n', '<ESC>', ':noh<CR><ESC>', { noremap = true, silent = true })

-- Aligning 
keymap('n', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })
keymap('x', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })

-- remove some unwanted bindings
keymap('n', '<leader>hp', '<nop>')
keymap('n', '<leader>hs', '<nop>')
keymap('n', '<leader>hu', '<nop>')
keymap('n', '<leader>nr', '<nop>')

-- Exit Terminal mode
keymap('t', '<leader><Esc>', '<C-\\><C-n>')

-- vim.g.copilot_no_tab_map = true
-- Uncomment to enable copilot autocompletion
-- keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Nibbler
keymap('n', '<C-b>', '<cmd>NibblerToggle<cr>')
keymap('v', '<C-b>', '<cmd>NibblerToggle<cr>')

keymap('n', 'gD', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })

-- Move cursor when scrolling with 'j' and 'k'
keymap('n', '<C-e>', '<C-e>j')
keymap('n', '<C-y>', '<C-y>k')


-- vim.api.nvim_set_keymap('n', '<leader>dv', ':DiffviewOpen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>gl', ':DiffviewFileHistory<CR>', { noremap = true, silent = true })

-- Lead key mappings with which key for some graphical help
 
local wk = require("which-key")

wk.setup({
    icons = {
        mappings = false, -- disable icons for mappings
    },
})

wk.add({
  { "<leader>f", group = "File" },
  { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Tree" },
  { "<leader>fl", '<cmd>:lua require"search_files".project_files()<cr>', desc = "Locate project files" },
  { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Browse files" },
  { "<leader>fh", ":lua MiniStarter.open()<cr>", desc = "Home window" },
  { "<leader>fw", "<cmd>write<cr>", desc = "Write file" },
  { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
  { "<leader>fo", "<cmd>Oil<cr>", desc = "Oil" },
  { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },

  { "<leader>s", group = "Search" },
  { "<leader>ss", '<cmd>:silent lua require("functions").grep_project()<cr>', desc = "Search Project" },
  { "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
  { "<leader>sb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
  { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "Commands (Plugin)" },
  { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "quickfix list" },

  { "<leader>g", group = "Git" },
  { "<leader>gg", "<cmd>Neogit<cr>", desc = "Git status" },
  { "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "Branches" },
  { "<leader>gB", "<cmd>Git blame<cr>", desc = "Blame" },
  { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Commits" },
  { "<leader>gh", "<cmd>GitGutterPreviewHunk<cr>", desc = "Preview hunk" },
  { "<leader>gs", "<cmd>GitGutterStageHunk<cr>", desc = "Stage hunk" },
  { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff" },
  { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "History diff" },
  { "<leader>gn", "<cmd>GitGutterNextHunk<cr>", desc = "Next hunk" },
  { "<leader>gp", "<cmd>GitGutterPrevHunk<cr>", desc = "Previous hunk" },
  { "<leader>gm", "<cmd>Git mergetool<cr>", desc = "Merge tool" },
  { "<leader>gl", "<cmd>GV<cr>", desc = "Log" },
  { "<leader>gL", "<cmd>GV --reflog<cr>", desc = "Reflog" },
  { "<leader>gf", "<cmd>Git fetch --all<cr>", desc = "Fetch all" },
  { "<leader>gu", "<cmd>GitGutterUndoHunk<cr>", desc = "Undo hunk" },

  { "<leader>h", group = "Help" },
  { "<leader>hk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
  { "<leader>hm", "<cmd>FzfLua manpages<cr>", desc = "Man pages" },
  { "<leader>hh", "<cmd>FzfLua help_tags<cr>", desc = "help (manual/plugins)" },
  { "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options" },

  { "<leader>t", group = "Tab" },
  { "<leader>tn", "<cmd>tabnew<cr>", desc = "New tab" },
  { "<leader>th", "<cmd>tabp<cr>", desc = "Previous tab" },
  { "<leader>tl", "<cmd>tabn<cr>", desc = "Next tab" },
  { "<leader>td", "<cmd>tabclose<cr>", desc = "Delete tab" },

  { "<leader>c", group = "Code" },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
  { "<leader>cR", "<cmd>Spectre<cr>", desc = "Replace" },
  { "<leader>cr", "<cmd>FzfLua lsp_references<cr>", desc = "References" },
  { "<leader>cs", ":lua vim.lsp.buf.document_symbol()<cr>", desc = "Document symbol" },
  { "<leader>cT", "<cmd>TodoQuickFix<cr>", desc = "Todo's" },
  { "<leader>ct", "<cmd>Trouble<cr>", desc = "Trouble" },
  { "<leader>cc", ":PickColor<cr>", desc = "Color picker" },
  { "<leader>cP", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview definition" },
  { "<leader>cl", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" },
  { "<leader>cy", "yypk<Plug>(comment_toggle_linewise_current)j", desc = "Comment and copy" },
  { "<leader>cp", "<Plug>(comment_toggle_linewise)ip", desc = "Comment paragraph" },

  { "<leader>m", group = "Marks/Harpoon" },
  { "<leader>mm", ":lua require('harpoon.mark').add_file()<cr>", desc = "HarpoonMark" },
  { "<leader>mM", "<cmd>mark<cr>", desc = "Mark" },
  { "<leader>mo", "<cmd>FzfLua marks<cr>", desc = "Open marks" },
  { "<leader>m<leader>", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Open Marks" },

  { "<leader>b", group = "buffer" },
  { "<leader>bd", "<cmd>lua MiniBufremove.delete(0, false)<cr>", desc = "Delete buffer" },
  { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "buffers" },

  { "<leader>d", group = "Debugger" },
  { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Breakpoint (Toggle)" },
  { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
  { "<leader>ds", "<cmd>DapStepInto<cr>", desc = "Step into" },
  { "<leader>dS", "<cmd>DapStepOver<cr>", desc = "Step over" },
  { "<leader>do", "<cmd>DapStepOut<cr>", desc = "Step out" },
  { "<leader>dQ", "<cmd>DapTerminate<cr>", desc = "Quit debugging" },

  { "<leader>o", group = "Org" },

  { "<leader>n", group = "Notes/Org-Roam" },

  { "<leader>a", group = "AI" },
  { "<leader>at", "<cmd>CodeCompanionToggle<cr>", desc = "Toggle AI" },
  { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "Chat AI" },
  { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions AI" },

  { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen mode" },
  { "<leader>M", "<cmd>Noice<cr>", desc = "Messages (Neovim)" },
  { "<leader>C", "<cmd>FzfLua colorschemes<cr>", desc = "Colorscheme" },
  { "<leader>q", '<cmd>:silent lua require("functions").toggle_qf()<cr>', desc = "Toggle quickfix list" },
  { "<leader>w", proxy = "<c-w>", group = "Window" },
  { "<leader>p", ":FzfLua neoclip<cr>", desc = "Paste" },
  { "<leader>j", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
  { "<leader>J", "<cmd>AnyJump<cr>", desc = "AnyJump" },
  { "<leader>D", ":lua toggleDarkMode()<cr>", desc = "Toggle dark mode" },
  { "<leader><space>", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
  { "<leader>*", "<cmd>FzfLua grep_cword<cr>", desc = "Grep under cursor" },
  { "<leader>/", "<cmd>FzfLua blines<cr>", desc = "Fuzzy find in buffer" },
  { "<leader>;", "<cmd>FzfLua commands<cr>", desc = "Commands (Plugin)" },
})



