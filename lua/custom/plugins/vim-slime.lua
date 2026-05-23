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

local function slime_send(lines)
  local min = math.huge
  for _, l in ipairs(lines) do
    if l:match '%S' then min = math.min(min, #(l:match '^%s*')) end
  end
  if min == math.huge then min = 0 end
  local dedented = vim.tbl_map(function(l) return l:sub(min + 1) end, lines)
  vim.fn.chansend(vim.b.slime_config.jobid, table.concat(dedented, '\n') .. '\n')
end

_G._slime_operator = function(type)
  local s = vim.api.nvim_buf_get_mark(0, '[')
  local e = vim.api.nvim_buf_get_mark(0, ']')
  local lines = vim.api.nvim_buf_get_lines(0, s[1] - 1, e[1], false)
  if type == 'char' then
    lines[#lines] = lines[#lines]:sub(1, e[2] + 1)
    lines[1] = lines[1]:sub(s[2] + 1)
  end
  slime_send(lines)
end

return {
  'jpalardy/vim-slime',
  init = function()
    vim.g.slime_target = 'neovim'
    vim.g.slime_no_mappings = 1
  end,
  keys = {
    {
      'gz',
      function()
        if not auto_configure_slime() then return end
        vim.o.operatorfunc = 'v:lua._slime_operator'
        return 'g@'
      end,
      expr = true,
      desc = 'Send motion to terminal',
    },
    {
      'gzz',
      function()
        if not auto_configure_slime() then return end
        slime_send { vim.fn.getline '.' }
      end,
      desc = 'Send line to terminal',
    },
    {
      'gz',
      function()
        if not auto_configure_slime() then return end
        local s, e = vim.fn.line "'<", vim.fn.line "'>"
        slime_send(vim.api.nvim_buf_get_lines(0, s - 1, e, false))
      end,
      mode = 'x',
      desc = 'Send selection to terminal',
    },
  },
}
