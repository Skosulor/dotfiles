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
        m =  { '<cmd>:lua require("functions").man_pages()<cr>', 'Man pages' },
        d =  { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
        k =  { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
        h =  { '<cmd>Telescope help_tags<cr>', 'Help tags (plugin)' },
        b =  { '<cmd>Telescope buffers<cr>', 'Buffers' },
        c =  { '<cmd>Telescope commands<cr>', 'Commands (Plugin)' },
    },

    g = {
        name = "Git",
        g =  { '<cmd>Git<cr>', 'Git status' },
        b =  { '<cmd>Telescope git_branches<cr>', 'Branches' },
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

    c = {
        name = "Code",
        a =   { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code action"},
        r =  { '<cmd>Spectre<cr>', 'Replace' },
        s =  { ':lua vim.lsp.buf.document_symbol()<cr>', 'Document symbol' },
        T =  { '<cmd>TodoQuickFix<cr>', 'Todo\'s' },
        t =  { '<cmd>Trouble<cr>', 'Trouble' },
        l =  { '<cmd>Commentary<cr>', 'Comment' },
        P =  { ':PickColor<cr>', 'Pick Color' },
        p =  { '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', 'Preview definition' },
    },


    w = { '<C-W>', 'Window' },
    p = { ':Telescope neoclip<cr>', 'Paste' },
    j = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document symbols'},
    J = { '<cmd>Telescope lsp_workspace_symbols<cr>', 'Workspace symbols' },
    d = { ':lua toggleDarkMode()<cr>', 'Toggle dark mode' },
    ['*'] =  { '<cmd>Telescope grep_string<cr>', 'Grep under cursor' },
    ["/"] = {':lua require("telescope.builtin").current_buffer_fuzzy_find({ sorter = require("telescope.sorters").get_substr_matcher({})})<cr>', 'Fuzzy find in buffer'}, 

}, {prefix = "<leader>" })



