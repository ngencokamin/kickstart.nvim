local function send_range(start_line, end_line)
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  vim.cmd(('%d,%dCodexSend'):format(start_line, end_line))
end

_G.CodexSendMotion = function(_motion_type)
  send_range(vim.fn.line "'[", vim.fn.line "']")
end

local function send_current_line()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  send_range(line, line)
end

local function send_motion()
  vim.o.operatorfunc = 'v:lua.CodexSendMotion'
  return 'g@'
end

local function not_supported(feature)
  return function() vim.notify(('codex.nvim does not expose %s like claudecode.nvim'):format(feature), vim.log.levels.INFO) end
end

return {
  'ishiooon/codex.nvim',
  dependencies = { 'folke/snacks.nvim' },
  config = function()
    local notify_path = '/tmp/codex.nvim/notify.jsonl'
    require('codex').setup {
      terminal = {
        provider = 'snacks',
        split_side = 'right',
        split_width_percentage = 0.30,
        maximized_width_percentage = 0.96,
        maximized_height_percentage = 0.96,
        unfocus_key = '<C-x>',
      },
      diff_opts = {
        keep_terminal_focus = false,
        open_in_new_tab = true,
      },
      status_indicator = {
        cli_notify_path = notify_path,
      },
    }
  end,
  keys = {
    { '<leader>a', nil, desc = 'AI/Codex' },
    { '<leader>ac', '<cmd>Codex<cr>', desc = 'Toggle Codex (split)' },
    { '<leader>aF', '<cmd>CodexMaximizeToggle<cr>', desc = 'Toggle Codex (modal)' },
    { '<leader>af', '<cmd>CodexFocus<cr>', desc = 'Focus Codex' },
    { '<leader>ar', not_supported('session resume'), desc = 'Resume Codex' },
    { '<leader>aC', not_supported('session continue'), desc = 'Continue Codex' },
    { '<leader>am', '<cmd>CodexSelectModel<cr>', desc = 'Select Codex model' },
    { '<leader>as', '<cmd>CodexSend<cr>', mode = 'v', desc = 'Send selection to Codex' },
    {
      '<leader>as',
      send_motion,
      expr = true,
      desc = 'Send motion/text object to Codex',
      mode = 'n',
    },
    { '<leader>al', send_current_line, desc = 'Send current line to Codex' },
    { '<leader>ab', '<cmd>CodexAdd %<cr>', desc = 'Add current buffer to Codex' },
    { '<leader>aB', '<cmd>1,$CodexSend<cr>', desc = 'Send current buffer to Codex' },
    {
      '<leader>as',
      '<cmd>CodexTreeAdd<cr>',
      desc = 'Add file to Codex',
      ft = { 'NvimTree', 'neo-tree', 'neo-tree-popup', 'oil', 'minifiles', 'netrw' },
    },
    { '<leader>aa', '<cmd>CodexDiffAccept<cr>', desc = 'Accept Codex diff' },
    { '<leader>ad', '<cmd>CodexDiffDeny<cr>', desc = 'Deny Codex diff' },
  },
}
