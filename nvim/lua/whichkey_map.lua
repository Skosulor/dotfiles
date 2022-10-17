M = {}
function M.setup()

require("whichkey_setup").config{
    hide_statusline = false,
    default_keymap_settings = {
        silent=true,
        noremap=true,
    },
    default_mode = 'n',
}

local wk = require('whichkey_setup')
local keymap = {
    
    j = 'split args', -- only set a text for an already configured keymap
    ['<CR>'] = {'@q', 'macro q'}, -- setting a special key

    n = { -- set a nested structure
        name = '+comment',
        n = {'<Cmd>NERDCommenterComment<CR>', 'Comment'},
        },

    f = { -- set a nested structure
        name = '+find',
        b = {'<Cmd>Telescope buffers<CR>', 'buffers'},
    }
}
wk.register_keymap('leader', keymap)
end

return M
