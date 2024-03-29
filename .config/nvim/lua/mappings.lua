
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
keymap('n', 'gr', '<cmd>Telescope lsp_references<cr>')
keymap('x', '<leader>ch', ':ClangdSwitchSourceHeader<cr>')

-- Tabs
keymap('n', '<C-n>', '<CMD>tab new<cr><CMD>lua MiniStarter.open()<cr>', { noremap = true, silent = true })
keymap('n', '<C-l>', '<CMD>tabn<cr>', { noremap = true, silent = true })
keymap('n', '<C-h>', '<CMD>tabp<cr>', { noremap = true, silent = true })
keymap('t', '<C-n>', '<CMD>tab new<cr>', { noremap = true, silent = true })
keymap('t', '<C-l>', '<CMD>tabn<cr>', { noremap = true, silent = true })
keymap('t', '<C-h>', '<CMD>tabp<cr>', { noremap = true, silent = true })
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

vim.g.copilot_no_tab_map = true
-- Uncomment to enable copilot autocompletion
keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Nibbler
keymap('n', '<C-b>', '<cmd>NibblerToggle<cr>')
keymap('v', '<C-b>', '<cmd>NibblerToggle<cr>')

keymap('n', 'gD', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })

-- Move cursor when scrolling with 'j' and 'k'
keymap('n', '<C-e>', '<C-e>j')
keymap('n', '<C-y>', '<C-y>k')

-- Lead key mappings with which key for some graphical help
local wk = require("which-key")
wk.register({
    f = {
        name = "File",
        t = { '<cmd>NvimTreeToggle<cr>', "Toggle Tree" },
        s = { '<cmd>:lua require"search_files".project_files()<cr>', 'Search project files' },
        f = { '<cmd>Telescope file_browser<cr>', 'Browse files'},
        h = { ':lua MiniStarter.open()<cr>', 'Home window' },
        w = { '<cmd>write<cr>', 'Write file' },
        r = { '<cmd>Telescope oldfiles<cr>', 'Recent files' },
        o = { '<cmd>Oil<cr>', 'Oil' },
        p = { '<cmd>Telescope projects<cr>', 'Projects' },
    },
    s = {
        name = "Search",
        s =  { '<cmd>:silent lua require("functions").grep_project()<cr>', 'Search Project' },
        d =  { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
        b =  { '<cmd>Telescope buffers<cr>', 'Buffers' },
        c =  { '<cmd>Telescope commands<cr>', 'Commands (Plugin)' },
        q =  { '<cmd>Telescope quickfixhistory<cr>', 'Quickfix history' },
    },

    g = {
        name = "Git",
        g =  { '<cmd>Neogit<cr>', 'Git status' },
        b =  { '<cmd>Telescope git_branches<cr>', 'Branches' },
        B =  { '<cmd>Git blame<cr>', 'Blame' },
        c =  { '<cmd>Telescope git_commits<cr>', 'Commits' },
        h =  { '<cmd>GitGutterPreviewHunk<cr>', 'Preview hunk' },
        s =  { '<cmd>GitGutterStageHunk<cr>', 'Stage hunk' },
        d =  { '<cmd>GitGutterDiffOrig<cr>', 'Diff' },
        n =  { '<cmd>GitGutterNextHunk<cr>', 'Next hunk' },
        p =  { '<cmd>GitGutterPrevHunk<cr>', 'Previous hunk' },
        m =  { '<cmd>Git mergetool<cr>', 'Merge tool' },
        l =  { '<cmd>GV<cr>', 'Log' },
        L =  { '<cmd>GV --reflog<cr>', 'Reflog' },
        f =  { '<cmd>Git fetch --all<cr>', 'Fetch all' },
        u =  { '<cmd>GitGutterUndoHunk<cr>', 'Undo hunk' },
    },

    h = {
        name = "Help",
        k =  { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
        m =  { '<cmd>:lua require("functions").man_pages()<cr>', 'Man pages' },
        h =  { '<cmd>Telescope help_tags<cr>', 'help (manual/plugins)' },
        o =  { '<cmd>Telescope vim_options<cr>', 'Options' },
    },

    c = {
        name = "Code",
        a =   { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code action"},
        R =  { '<cmd>Spectre<cr>', 'Replace' },
        r = { '<cmd>Telescope lsp_references<cr>', 'References' },
        s =  { ':lua vim.lsp.buf.document_symbol()<cr>', 'Document symbol' },
        T =  { '<cmd>TodoQuickFix<cr>', 'Todo\'s' },
        t =  { '<cmd>Trouble<cr>', 'Trouble' },
        c =  { ':PickColor<cr>', 'Color picker' },
        P =  { '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', 'Preview definition' },
        l =  { '<Plug>(comment_toggle_linewise_current)', 'Comment' },
        y =  { 'yypk<Plug>(comment_toggle_linewise_current)j', 'Comment and copy' },
        p =  { '<Plug>(comment_toggle_linewise)ip', 'Comment paragraph' },
    },

    m = {
        name = 'Marks/Harpoon',
        m = {':lua require("harpoon.mark").add_file()<cr>', 'HarpoonMark'},
        M = {'<cmd>mark<cr>', 'Mark'},
        o = {'<cmd>Telescope marks<cr>'},
        ['<leader>'] = {':lua require("harpoon.ui").toggle_quick_menu()<cr>', 'Open Marks'},
    }, 

    b = {
        name = "buffer",
        d = {'<cmd>lua MiniBufremove.delete(0, false)<cr>', 'Delete buffer'},
        b = {'<cmd>Telescope buffers<cr>', 'buffers'},
    },

    d = {
        name = "Debugger",
        b = { '<cmd>DapToggleBreakpoint<cr>', 'Breakpoint (Toggle)' },
        c = { '<cmd>DapContinue<cr>', 'Continue' },
        s = { '<cmd>DapStepInto<cr>', 'Step into' },
        S = { '<cmd>DapStepOver<cr>', 'Step over' },
        o = { '<cmd>DapStepOut<cr>', 'Step out' },
        Q = { '<cmd>DapTerminate<cr>', 'Quit debugging' },
    },

    o = {
        name = "Obsidian",
        n = { '<cmd>ObsidianNew<cr>', 'New'},
        o = { '<cmd>ObsidianQuickSwitch<cr>', 'Open'},
        O = { '<cmd>ObsidianOpen<cr>', 'Open Obsidian'},
        t = { '<cmd>ObsidianToday<cr>', 'Today'},
        y = { '<cmd>ObsidianYesterday<cr>', 'Yesterday'},
        s = { '<cmd>ObsidianSearch<cr>', 'Search'},
    },


    a = { '<Plug>(EasyAlign)ip', 'Align' },
    z = { '<cmd>ZenMode<cr>', 'Zen mode' },
    M = { '<cmd>Noice<cr>', 'Messages (Neovim)' },
    C = { '<cmd>Telescope colorscheme<cr>', 'Colorscheme' },
    q = { '<cmd>:silent lua require("functions").toggle_qf()<cr>', 'Toggle quickfix list' },
    w = { '<C-W>', 'Window' },
    p = { ':Telescope neoclip<cr>', 'Paste' },
    j = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document symbols'},
    J = { '<cmd>Telescope lsp_workspace_symbols<cr>', 'Workspace symbols' },
    D = { ':lua toggleDarkMode()<cr>', 'Toggle dark mode' },
    ['<space>'] = { '<cmd>Telescope buffers<cr>', 'Buffers' },
    ['*'] =  { '<cmd>Telescope grep_string<cr>', 'Grep under cursor' },
    ["/"] = {':lua require("telescope.builtin").current_buffer_fuzzy_find({ sorter = require("telescope.sorters").get_substr_matcher({})})<cr>', 'Fuzzy find in buffer'}, 

}, {prefix = "<leader>" })



