
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


keymap('n', '<A-h>', '<C-w>h')
keymap('n', '<A-n>', '<C-w>j')
keymap('n', '<A-e>', '<C-w>k')
keymap('n', '<A-i>', '<C-w>l')


-- Non leader key bindings
keymap('n', 'gr', '<nop>')
keymap('n', 'gr', '<cmd>lua Snacks.picker. lsp_references<cr>')
keymap('x', '<leader>ch', ':ClangdSwitchSourceHeader<cr>')

-- Tabs
-- keymap('n', '<C-n>', '<CMD>tab new<cr><CMD>lua MiniStarter.open()<cr>', { noremap = true, silent = true })
-- keymap('t', '<C-n>', '<CMD>tab new<cr>', { noremap = true, silent = true })
-- keymap('n', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })
-- keymap('t', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })

-- LSP
keymap('n', '<C-a>', ':lua vim.lsp.buf.definition()<cr>')
keymap('n', '<C-p>', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })
keymap('n', 'gl', ':lua vim.diagnostic.open_float()<cr>')
keymap('n', 'J', ':lua vim.lsp.buf.hover()<enter>')

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

-- 
keymap('n', '<C-b>', '<cmd>NibblerToggle<cr>')
keymap('v', '<C-b>', '<cmd>NibblerToggle<cr>')


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

-- Improve completion experience
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

wk.add({
  { "<leader>f", group = "File" },
  { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
  { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Tree" },
  { "<leader>fl", '<cmd>:lua require"search_files".project_files()<cr>', desc = "Locate project files" },
  { "<leader>ff", "<cmd>lua Snacks.picker.files()<cr>", desc = "Browse files" },
  { "<leader>fh", ":lua MiniStarter.open()<cr>", desc = "Home window" },
  { "<leader>fw", "<cmd>write<cr>", desc = "Write file" },
  { "<leader>fr", "<cmd>lua Snacks.picker.recent()<cr>", desc = "Recent files" },
  { "<leader>fo", "<cmd>Oil<cr>", desc = "Oil" },
  { "<leader>fp", "<cmd>lua Snacks.picker.projects()cr>", desc = "Projects" },

  { "<leader>s", group = "Search" },
  { "<leader>ss", '<cmd>:silent lua require("functions").grep_project()<cr>', desc = "Search Project" },
  { "<leader>sd", "<cmd>lua Snacks.picker.diagnostics()<cr>", desc = "Diagnostics" },
  { "<leader>sb", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "Buffers" },
  { "<leader>sc", "<cmd>lua Snacks.picker.commands()<cr>", desc = "Commands (Plugin)" },
  { "<leader>sq", "<cmd>lua Snacks.picker.qflist()<cr>", desc = "quickfix list" },

  { "<leader>g", group = "Git" },
  { "<leader>gg", "<cmd>Neogit<cr>", desc = "Git status" },
  { "<leader>gb", "<cmd>lua Snacks.picker.git_branches()<cr>", desc = "Branches" },
  { "<leader>gB", "<cmd>Git blame<cr>", desc = "Blame" },
  { "<leader>gc", "<cmd>lua Snacks.picker.git_log()<cr>", desc = "Commits" },
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
  { "<leader>gf", '<cmd>:lua require"search_files".checkout_blob()<cr>', desc = "view blob/file" },
  { "<leader>gu", "<cmd>GitGutterUndoHunk<cr>", desc = "Undo hunk" },

  { "<leader>h", group = "Help" },
  { "<leader>hk", "<cmd>lua Snacks.picker.keymaps()<cr>", desc = "Keymaps" },
  { "<leader>hm", "<cmd>lua Snacks.picker.man()<cr>", desc = "Man pages" },
  { "<leader>hh", "<cmd>lua Snacks.picker.help()<cr>", desc = "help (manual/plugins)" },
  { "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options" },

  { "<leader>t", group = "Tab" },
  { "<leader>tn", "<cmd>tabnew<cr>", desc = "New tab" },
  { "<leader>th", "<cmd>tabp<cr>", desc = "Previous tab" },
  { "<leader>tl", "<cmd>tabn<cr>", desc = "Next tab" },
  { "<leader>td", "<cmd>tabclose<cr>", desc = "Delete tab" },

  { "<leader>c", group = "Code" },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
  { "<leader>cR", "<cmd>Spectre<cr>", desc = "Replace" },
  { "<leader>cr", "<cmd>lua Snacks.picker.lsp_references()<cr>", desc = "References" },
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
  { "<leader>mo", "<cmd>lua Snacks.picker.marks()<cr>", desc = "Open marks" },
  { "<leader>m<leader>", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Open Marks" },

  { "<leader>b", group = "buffer" },
  { "<leader>bd", "<cmd>lua MiniBufremove.delete(0, false)<cr>", desc = "Delete buffer" },
  { "<leader>bb", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "buffers" },

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
  { "<leader>C", "<cmd>lua Snacks.picker.colorschemes()<cr>", desc = "Colorscheme" },
  { "<leader>q", '<cmd>:silent lua require("functions").toggle_qf()<cr>', desc = "Toggle quickfix list" },

  { "<leader>wh", "<C-w>h", desc = "Go to left window"},
  { "<leader>wn", "<C-w>j", desc = "Go to lower window"},
  { "<leader>we", "<C-w>k", desc = "Go to upper window"},
  { "<leader>wi", "<C-w>l", desc = "Go to right window"},
  { "<leader>wv", "<C-w>v", desc = "Split window vertically"},
  { "<leader>ws", "<cmd>split<cr>", desc = "Split window horizontally"},
  { "<leader>wq", "<C-w>q", desc = "Quit current window"},

  { "<leader>p", ":FzfLua neoclip<cr>", desc = "Paste" },
  { "<leader>j", "<cmd>lua Snacks.picker.lsp_symbols()<cr>", desc = "Document symbols" },
  { "<leader>J", "<cmd>AnyJump<cr>", desc = "AnyJump" },
  { "<leader>D", ":lua toggleDarkMode()<cr>", desc = "Toggle dark mode" },
  { "<leader><space>", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "Buffers" },
  { "<leader>*", "<cmd>lua Snacks.picker.grep_word()<cr>", desc = "Grep under cursor" },
  { "<leader>/", "<cmd>lua Snacks.picker.lines()<cr>", desc = "Fuzzy find in buffer" },
  { "<leader>;", "<cmd>lua Snacks.picker.commands()<cr>", desc = "Commands (Plugin)" },
})



-- Colemak remaps

vim.g.colemak_enabled = true

-- Function to set Colemak mappings
local function enable_colemak()
    -- Normal mode
    vim.keymap.set('n', 'h', 'h', { noremap = true })
    vim.keymap.set('n', 'e', 'k', { noremap = true })
    vim.keymap.set('n', 'n', 'j', { noremap = true })
    vim.keymap.set('n', 'i', 'l', { noremap = true })
    vim.keymap.set('n', 'l', 'i', { noremap = true })
    vim.keymap.set('n', 'k', 'n', { noremap = true })
    vim.keymap.set('n', 'j', 'e', { noremap = true })

    -- Visual mode
    vim.keymap.set('v', 'h', 'h', { noremap = true })
    vim.keymap.set('v', 'e', 'k', { noremap = true })
    vim.keymap.set('v', 'n', 'j', { noremap = true })
    vim.keymap.set('v', 'i', 'l', { noremap = true })
    vim.keymap.set('v', 'l', 'i', { noremap = true })
    vim.keymap.set('v', 'k', 'n', { noremap = true })
    vim.keymap.set('v', 'j', 'e', { noremap = true })

    -- Operator mode
    vim.keymap.set('o', 'n', 'j', { noremap = true })
    vim.keymap.set('o', 'e', 'k', { noremap = true })
    vim.keymap.set('o', 'l', 'i', { noremap = true })
    vim.keymap.set('o', 'i', 'l', { noremap = true })

    -- Search
    vim.keymap.set('v', 'K', 'N', { noremap = true })
    vim.keymap.set('n', 'K', 'N', { noremap = true })
end

-- Function to restore default mappings
local function disable_colemak()
    -- Instead of deleting, we'll map keys back to their original functions
    vim.keymap.set('n', 'h', 'h', { noremap = true })
    vim.keymap.set('n', 'j', 'j', { noremap = true })
    vim.keymap.set('n', 'k', 'k', { noremap = true })
    vim.keymap.set('n', 'l', 'l', { noremap = true })
    vim.keymap.set('n', 'i', 'i', { noremap = true })
    vim.keymap.set('n', 'n', 'n', { noremap = true })
    vim.keymap.set('n', 'e', 'e', { noremap = true })

    vim.keymap.set('v', 'h', 'h', { noremap = true })
    vim.keymap.set('v', 'j', 'j', { noremap = true })
    vim.keymap.set('v', 'k', 'k', { noremap = true })
    vim.keymap.set('v', 'l', 'l', { noremap = true })
    vim.keymap.set('v', 'i', 'i', { noremap = true })
    vim.keymap.set('v', 'n', 'n', { noremap = true })
    vim.keymap.set('v', 'e', 'e', { noremap = true })

    vim.keymap.set('o', 'h', 'h', { noremap = true })
    vim.keymap.set('o', 'j', 'j', { noremap = true })
    vim.keymap.set('o', 'k', 'k', { noremap = true })
    vim.keymap.set('o', 'l', 'l', { noremap = true })
    vim.keymap.set('o', 'i', 'i', { noremap = true })
    vim.keymap.set('o', 'n', 'n', { noremap = true })
    vim.keymap.set('o', 'e', 'e', { noremap = true })

    -- Reset search keys
    vim.keymap.set('n', 'n', 'n', { noremap = true })
    vim.keymap.set('n', 'N', 'N', { noremap = true })
    vim.keymap.set('v', 'n', 'n', { noremap = true })
    vim.keymap.set('v', 'N', 'N', { noremap = true })
end


-- Toggle function
function _G.toggle_colemak()
    vim.g.colemak_enabled = not vim.g.colemak_enabled
    if vim.g.colemak_enabled then
        enable_colemak()
        vim.notify("Colemak mode enabled")
    else
        disable_colemak()
        vim.notify("Colemak mode disabled")
    end
end

-- Initialize Colemak mode on startup
enable_colemak()

-- Add keybinding to toggle (you can add this to your which-key config)
vim.api.nvim_set_keymap('n', '<leader>k', ':lua toggle_colemak()<CR>', 
    { noremap = true, silent = true, desc = "Toggle Colemak" })
