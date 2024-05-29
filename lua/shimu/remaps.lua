local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Move selection up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Text: Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Text: Move selection up' })

-- Move row up
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Text: Move line from under to same line' })
-- Delete a word backwards
vim.keymap.set('n', 'dw', 'vb_d', { desc = 'Text: Delete a word backwards' })

-- Select all
vim.keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = 'Text: Select all text' })

-- Jumplist
vim.keymap.set('n', '<C-m>', '<C-i>', opts)

-- Split window
vim.keymap.set('n', 'ss', ':split<Return>', { desc = 'Window: Split window horizontally', noremap = true, silent = true })
vim.keymap.set('n', 'sv', ':vsplit<Return>', { desc = 'Window: Split window vertically', noremap = true, silent = true })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- Navigate through windows
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Window: Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Window: Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Window: Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Window: Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Window: Move focus to the upper window' })

-- Move window
vim.keymap.set('n', 'sh', '<C-w>h', { desc = 'Window: Move window left' })
vim.keymap.set('n', 'sk', '<C-w>k', { desc = 'Window: Move window up' })
vim.keymap.set('n', 'sj', '<C-w>j', { desc = 'Window: Move window down' })
vim.keymap.set('n', 'sl', '<C-w>l', { desc = 'Window: Move window right' })

-- Resize window
vim.keymap.set('n', '<C-w><left>', '<C-w><', { desc = 'Window: Decrease window width' })
vim.keymap.set('n', '<C-w><right>', '<C-w>>', { desc = 'Window: Increase window width' })
vim.keymap.set('n', '<C-w><up>', '<C-w>+', { desc = 'Window: Increase window height' })
vim.keymap.set('n', '<C-w><dow>', '<C-w>-', { desc = 'Window: Decrease window height' })

-- Scroll up/down document
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Text: Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Text: Scroll up' })

-- Yank line?
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Delete to black hole register
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- Exit insert mode with CTRL+c
vim.keymap.set('i', '<C-c>', '<Esc>')

-- WARN: ?????
vim.keymap.set('n', 'Q', '<nop>')

-- Replace all occurences in the document
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Text: Replace all occurences in a document' })

-- Navigate diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diag: Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diag: Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diag: Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diag: Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Diag: Toggle diagnostics' })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('shimu-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
