return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-\\>', desc = 'Toggle terminal' },
      { '<leader>tf', '<cmd>2ToggleTerm direction=float<cr>', desc = '[T]erm [f]loat' },
      { '<leader>th', '<cmd>3ToggleTerm direction=horizontal<cr>', desc = '[T]erm [h]orizontal' },
      { '<leader>tv', '<cmd>4ToggleTerm direction=vertical size=60<cr>', desc = '[T]erm [v]ertical' },
      {
        '<leader>tg',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true }):toggle()
        end,
        desc = '[T]erm la[g]it',
      },
    },
    opts = {
      size = 20,
      open_mapping = [[<C-\>]],
      on_open = function(term)
        if term.direction == 'float' then
          vim.keymap.set({ 't', 'n' }, '<Esc>', '<cmd>close<cr>', { buffer = term.bufnr, silent = true, desc = 'Close float terminal' })
        end
      end,
    },
  },
}
