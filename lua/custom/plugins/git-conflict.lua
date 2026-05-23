return {
  'akinsho/git-conflict.nvim',
  version = '*',
  event = 'BufReadPre',
  opts = {
    default_mappings = false,
    disable_diagnostics = true,
  },
  keys = {
    { '<leader>mo', '<Plug>(git-conflict-ours)', desc = '[M]erge choose [O]urs' },
    { '<leader>mt', '<Plug>(git-conflict-theirs)', desc = '[M]erge choose [T]heirs' },
    { '<leader>mb', '<Plug>(git-conflict-both)', desc = '[M]erge choose [B]oth' },
    { '<leader>m0', '<Plug>(git-conflict-none)', desc = '[M]erge choose none' },
    { ']x', '<Plug>(git-conflict-next-conflict)', desc = 'Next conflict' },
    { '[x', '<Plug>(git-conflict-prev-conflict)', desc = 'Prev conflict' },
  },
}
