return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    cmdline = {
      format = {
        search_down = {
          view = 'cmdline',
        },
        search_up = {
          view = 'cmdline',
        },
      },
      view = 'cmdline',
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'hrsh7th/nvim-cmp',
  },
}
