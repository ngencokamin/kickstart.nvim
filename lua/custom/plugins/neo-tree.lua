return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim', 'nvim-tree/nvim-web-devicons', 's1n7ax/nvim-window-picker' },
    opts = {
      default_component_configs = {
        git_status = {
          symbols = {
            added = '',
            deleted = '',
            modified = 'M',
            renamed = '',
            untracked = '',
            ignored = '',
            unstaged = '●',
            staged = '',
            conflict = '',
          },
          align = 'right',
        },
      },
      commands = {
        diff_file = function(state)
          local node = state.tree:get_node()
          if node.type == 'file' then vim.cmd('DiffviewOpen -- ' .. vim.fn.fnameescape(node.path)) end
        end,
        blame_file = function(state)
          local node = state.tree:get_node()
          if node.type == 'file' then vim.cmd('Git blame ' .. vim.fn.fnameescape(node.path)) end
        end,
        file_history = function(state)
          local node = state.tree:get_node()
          if node.type == 'file' then vim.cmd('DiffviewFileHistory ' .. vim.fn.fnameescape(node.path)) end
        end,
      },
      window = {
        mappings = {
          ['P'] = {
            'toggle_preview',
            config = {
              use_float = true,
            },
          },
          ['gd'] = 'diff_file',
          ['gf'] = 'file_history',
          ['gb'] = 'blame_file',
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          never_show = {
            '.DS_Store',
            '.git/',
          },
        },
      },
    },
    keys = {
      {
        '<leader>n',
        function()
          require('neo-tree.command').execute {
            toggle = true,
            reveal = true,
            source = 'filesystem',
            position = 'float',
          }
        end,
        desc = '[N]eotree floating',
      },
      {
        '<leader>N',
        function()
          require('neo-tree.command').execute {
            toggle = true,
            source = 'filesystem',
            position = 'left',
          }
        end,
        desc = '[N]eotree Sidebar',
      },
    },
  },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-neo-tree/neo-tree.nvim' },
    lazy = false,
    config = function() require('lsp-file-operations').setup() end,
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    config = function()
      require('window-picker').setup {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          bo = {
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
            buftype = { 'terminal', 'quickfix' },
          },
        },
      }
    end,
  },
}
