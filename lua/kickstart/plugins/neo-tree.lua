-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>n', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
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
  },
}
