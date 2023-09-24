-- Using vscode extension for gdb
-- Download: https://github.com/microsoft/vscode-cpptools/releases
-- Unpack it. .vsix is a zip file and you can use unzip to extract the contents.
-- Ensure extension/debugAdapters/bin/OpenDebugAD7 is executable.

return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')

            dap.adapters.lldb = {
                type = 'server',
                port = "1234",
                executable = {
                    command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
                    args = {"--port", "1234"},
                }
            }

            dap.configurations.c = {
                {
                    name = "Launch file",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }
            end
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require "dapui".setup()
            local dap = require('dap')
            local dapui = require('dapui')
            dap.listeners.after.event_initialized["dapui_config"]=function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"]=function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"]=function()
                dapui.close()
            end
        end
    },

}

