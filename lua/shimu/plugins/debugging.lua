return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
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
