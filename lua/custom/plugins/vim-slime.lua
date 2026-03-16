local function auto_configure_slime()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == 'terminal' then
      if #vim.fn.win_findbuf(bufnr) > 0 then
        vim.b.slime_config = { jobid = vim.b[bufnr].terminal_job_id }
        return true
      end
    end
  end
  vim.notify('vim-slime: no visible terminal found', vim.log.levels.WARN)
  return false
end

return {
  'jpalardy/vim-slime',
  init = function()
    vim.g.slime_target = 'neovim'
    vim.g.slime_no_mappings = 1
    vim.g.slime_bracketed_paste = 1
  end,
  keys = {
    {
      'gz',
      function()
        if auto_configure_slime() then
          return '<Plug>SlimeMotionSend'
        end
      end,
      expr = true,
      desc = 'Send motion to terminal',
    },
    {
      'gzz',
      function()
        if auto_configure_slime() then
          vim.cmd('SlimeSendCurrentLine')
        end
      end,
      desc = 'Send line to terminal',
    },
    {
      'gz',
      function()
        if auto_configure_slime() then
          vim.cmd("'<,'>SlimeSend")
        end
      end,
      mode = 'x',
      desc = 'Send selection to terminal',
    },
  },
}