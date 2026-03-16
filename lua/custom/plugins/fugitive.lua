return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'Gvdiffsplit', 'Gread', 'Gwrite', 'GBrowse' },
  keys = {
    { '<leader>gg', '<cmd>Git<cr>', desc = '[G]it fu[G]itive' },
    { '<leader>gB', '<cmd>Git blame<cr>', desc = '[G]it [B]lame' },
    { '<leader>gl', '<cmd>Git log --oneline<cr>', desc = '[G]it [L]og' },
  },
}
