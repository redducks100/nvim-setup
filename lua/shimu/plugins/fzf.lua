return {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    keys = {
        { 
            "<leader>sf",
            function() require('fzf-lua').files() end,
            desc = "[S]earch [F]iles in project directory"
        },
        { 
            "<leader>sg",
            function() require('fzf-lua').live_grep() end,
            desc = "[S]earch by [G]repping in project directory"
        },
        { 
            "<leader>sn",
            function() require('fzf-lua').files({ cwd = vim.fn.stdpath("config") }) end,
            desc = "[S]earch in files in [N]eovim configuration directory"
        },
        { 
            "<leader>sk",
            function() require('fzf-lua').keymaps() end,
            desc = "[S]earch [K]eymaps"
        },
        { 
            "<leader>sw",
            function() require('fzf-lua').grep_cword() end,
            desc = "[S]earch current [W]ord"
        },
        { 
            "<leader>sW",
            function() require('fzf-lua').grep_cWORD() end,
            desc = "[S]earch current [W]ORD"
        },
        { 
            "<leader>sr",
            function() require('fzf-lua').resume() end,
            desc = "[S]earch [R]esume"
        },
        { 
            "<leader><leader>",
            function() require('fzf-lua').buffers() end,
            desc = "[ ] Search existing buffers",
        },
        { 
            "<leader>/",
            function() require('fzf-lua').lgrep_curbuf() end,
            desc = "[/] Live grep the current buffer",
        },
    }
}
