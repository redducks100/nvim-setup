return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
  opts = function()
    local dap = require 'dap'
    ---@param pkg string
    ---@param path? string
    ---@param opts? { warn?: boolean }
    local get_pkg_path = function(pkg, path, opts)
      pcall(require, 'mason') -- make sure Mason is loaded. Will fail when generating docs
      local root = vim.env.MASON or (vim.fn.stdpath 'data' .. '/mason')
      opts = opts or {}
      opts.warn = opts.warn == nil and true or opts.warn
      path = path or ''
      local ret = root .. '/packages/' .. pkg .. '/' .. path

      return ret
    end
    if not dap.adapters['pwa-node'] then
      require('dap').adapters['pwa-node'] = {

        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {

          command = 'node',

          -- 💀 Make sure to update this path to point to your installation

          args = {
            get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
            '${port}',
          },
        },
      }
    end
    if not dap.adapters['node'] then
      dap.adapters['node'] = function(cb, config)
        if config.type == 'node' then
          config.type = 'pwa-node'
        end
        local nativeAdapter = dap.adapters['pwa-node']
        if type(nativeAdapter) == 'function' then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

    local vscode = require 'dap.ext.vscode'
    vscode.type_to_filetypes['node'] = js_filetypes
    vscode.type_to_filetypes['pwa-node'] = js_filetypes

    for _, language in ipairs(js_filetypes) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',

            name = 'Launch file',

            program = '${file}',

            cwd = '${workspaceFolder}',
          },

          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',

            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
        }
      end
    end
  end,
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'

    ui.setup()

    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
    vim.keymap.set('n', '<leader>gb', dap.run_to_cursor, { desc = 'Debug: Run to cursor' })

    vim.keymap.set('n', '<leader>?', function()
      ui.eval(nil, { enter = true })
    end, { desc = 'Debug: Evaluate variable' })

    vim.keymap.set('n', '<F1>', dap.continue, { desc = 'Debug: Continue debugging' })
    vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'Debug: Step into' })
    vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'Debug: Step over' })
    vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'Debug: Step out' })
    vim.keymap.set('n', '<F5>', dap.step_back, { desc = 'Debug: Step back' })
    vim.keymap.set('n', '<F11>', dap.restart, { desc = 'Debug: Restart' })

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
