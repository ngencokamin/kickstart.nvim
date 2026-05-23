return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Used by claudecode.nvim as terminal provider
    terminal = { enabled = true },

    -- Pretty notification system (replaces vim.notify)
    notifier = {
      enabled = true,
      timeout = 3000,
    },

    -- Better vim.ui.input
    input = { enabled = true },

    -- Smooth scrolling
    scroll = { enabled = true },

    -- Quick file rendering before plugins load
    quickfile = { enabled = true },

    -- Indent guides
    indent = {
      enabled = true,
      animate = { enabled = false },
    },

    -- Open file/branch/commit in browser
    gitbrowse = { enabled = true },

    -- Dim inactive scopes
    dim = { enabled = true },

    -- Zen mode
    zen = { enabled = true },

    -- Scope detection and navigation
    scope = { enabled = true },

    -- Words / LSP reference navigation
    words = { enabled = true },
  },
  keys = {
    { '<leader>go', function() Snacks.gitbrowse() end, desc = '[G]it [O]pen in browser' },
    { '<leader>tz', function() Snacks.zen() end, desc = '[T]oggle [Z]en mode' },
    { '<leader>td', function() Snacks.dim() end, desc = '[T]oggle [D]im' },
    -- { '<leader>nh', function() Snacks.notifier.show_history() end, desc = '[N]otification [H]istory' },
    { ']]', function() Snacks.words.jump(1, true) end, desc = 'Next LSP reference', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-1, true) end, desc = 'Prev LSP reference', mode = { 'n', 't' } },
  },
}
