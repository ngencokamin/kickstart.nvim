return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    opts = {
      headerMaxWidth = 80,
    },
    keys = {
      {
        '<leader>fr',
        function() require('grug-far').open() end,
        desc = '[F]ind and [R]eplace',
      },
      {
        '<leader>fw',
        function()
          require('grug-far').open { prefills = {
            search = vim.fn.expand '<cword>',
            paths = vim.fn.expand '%',
          } }
        end,
        desc = '[F]ind current [W]ord',
      },
      {
        '<leader>fW',
        function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end,
        desc = '[F]ind current [W]ord in all files',
      },
      {
        '<leader>ff',
        function() require('grug-far').open { prefills = { paths = vim.fn.expand '%' } } end,
        desc = '[F]ind current [F]ile',
      },
      {
        '<leader>fs',
        function() require('grug-far').open { visualSelectionUsage = 'operate-within-range' } end,
        mode = { 'n', 'x' },
        desc = '[F]ind in [S]election',
      },
    },
  },
}
