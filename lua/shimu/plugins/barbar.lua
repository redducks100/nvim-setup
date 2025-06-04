return {
  'romgrk/barbar.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
    vim.keymap.set('n', '<Space>,', '<cmd>BufferPrevious<CR>', { desc = 'Move to previous buffer' })
    vim.keymap.set('n', '<Space>.', '<cmd>BufferNext<CR>', { desc = 'Move to next buffer' })
    vim.keymap.set('n', '<Space>c', '<cmd>BufferClose<CR>', { desc = 'Close current buffer' })
    vim.keymap.set('n', '<Space>p', '<cmd>BufferPin<CR>', { desc = 'Pin current buffer' })
    vim.keymap.set('n', '<Space>;', '<cmd>BufferPin<CR>', { desc = 'Close all but pinned and current buffers' })
  end,
  opts = {
    icons = {
      pinned = { button = '', filename = true },
    },
  },
  version = '^1.0.0',
}
