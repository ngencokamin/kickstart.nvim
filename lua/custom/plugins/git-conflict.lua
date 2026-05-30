return {
  'akinsho/git-conflict.nvim',
  version = '*',
  event = 'BufReadPre',
  opts = {
    default_mappings = false,
    disable_diagnostics = true,
  },
  config = function(_, opts)
    require('git-conflict').setup(opts)
    -- vim.diagnostic.enable/disable(bufnr) was replaced with enable(bool, {bufnr=n}) in Neovim 0.12
    -- Re-register the affected autocmds with the updated ATI
    local group = 'GitConflictCommands'
    vim.api.nvim_clear_autocmds({ group = group, pattern = 'GitConflictDetected' })
    vim.api.nvim_clear_autocmds({ group = group, pattern = 'GitConflictResolved' })
    if opts.disable_diagnostics then
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'GitConflictDetected',
        callback = function()
          vim.diagnostic.enable(false, { bufnr = vim.api.nvim_get_current_buf() })
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'GitConflictResolved',
        callback = function()
          vim.diagnostic.enable(true, { bufnr = vim.api.nvim_get_current_buf() })
        end,
      })
    end
  end,
  keys = {
    { '<leader>mo', '<Plug>(git-conflict-ours)', desc = '[M]erge choose [O]urs' },
    { '<leader>mt', '<Plug>(git-conflict-theirs)', desc = '[M]erge choose [T]heirs' },
    { '<leader>mb', '<Plug>(git-conflict-both)', desc = '[M]erge choose [B]oth' },
    { '<leader>m0', '<Plug>(git-conflict-none)', desc = '[M]erge choose none' },
    { ']x', '<Plug>(git-conflict-next-conflict)', desc = 'Next conflict' },
    { '[x', '<Plug>(git-conflict-prev-conflict)', desc = 'Prev conflict' },
  },
}
