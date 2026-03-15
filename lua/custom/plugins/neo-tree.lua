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
      window = {
        mappings = {
          ['P'] = {
            'toggle_preview',
            config = {
              use_float = true,
            },
          },
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
