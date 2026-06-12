-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '<leader>n', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        ['<leader>n'] = 'close_window',
        -- Add your new search mappings here
        ['tf'] = 'telescope_find',
        ['tg'] = 'telescope_grep',
      },
    },
    commands = {
      -- Custom command to find files in the current Neo-tree directory
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node.type == 'directory' and node:get_id() or vim.fn.fnamemodify(node:get_id(), ':h')
        require('telescope.builtin').find_files {
          cwd = path,
        }
      end,
      -- Custom command to grep in the current Neo-tree directory
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node.type == 'directory' and node:get_id() or vim.fn.fnamemodify(node:get_id(), ':h')
        require('telescope.builtin').live_grep {
          cwd = path,
        }
      end,
    },
  },
}
