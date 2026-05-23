local vaults = {
  { name = 'vault', path = '~/Documents/Vault' },
  { name = 'obsidian-ai', path = '~/Documents/Obsidian AI' },
}

local events = {}
for _, v in ipairs(vaults) do
  local expanded = vim.fn.expand(v.path)
  table.insert(events, 'BufReadPre ' .. expanded .. '/**/*.md')
  table.insert(events, 'BufNewFile ' .. expanded .. '/**/*.md')
end

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  event = events,
  dependencies = {
    'ibhagwan/fzf-lua',
  },
  opts = {
    workspaces = vaults,
    legacy_commands = false,
    picker = { name = 'fzf-lua' },
    attachments = { folder = 'assets' },
    ui = {
      ignore_conceal_warn = true,
      checkboxes = {
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '󰄲', hl_group = 'ObsidianDone' },
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
      },
    },
    checkbox = {
      order = { ' ', '~', '!', '>', 'x' },
    },
  },
  keys = {
    { '<leader>of', '<cmd>Obsidian quick_switch<cr>', desc = '[O]bsidian [F]ind note' },
    { '<leader>os', '<cmd>Obsidian search<cr>', desc = '[O]bsidian [S]earch' },
    { '<leader>on', '<cmd>Obsidian new<cr>', desc = '[O]bsidian [N]ew note' },
    { '<leader>oo', '<cmd>Obsidian open<cr>', desc = '[O]bsidian [O]pen in app' },
    { '<leader>ot', '<cmd>Obsidian tags<cr>', desc = '[O]bsidian [T]ags' },
    { '<leader>ob', '<cmd>Obsidian backlinks<cr>', desc = '[O]bsidian [B]acklinks' },
    { '<leader>ol', '<cmd>Obsidian links<cr>', desc = '[O]bsidian [L]inks' },
    { '<leader>oi', '<cmd>Obsidian paste_img<cr>', desc = '[O]bsidian paste [I]mage' },
    { '<leader>or', '<cmd>Obsidian rename<cr>', desc = '[O]bsidian [R]ename' },
    {
      '<leader>ovf',
      function()
        local items = {}
        for _, v in ipairs(vaults) do
          table.insert(items, v.name)
        end
        vim.ui.select(items, { prompt = 'Select vault:' }, function(choice)
          if not choice then return end
          vim.cmd('Obsidian workspace ' .. choice)
          vim.schedule(function() vim.cmd 'Obsidian quick_switch' end)
        end)
      end,
      desc = '[O]bsidian [V]ault [F]ind note',
    },
    {
      '<leader>ovt',
      function()
        local paths = {}
        local items = {}
        for _, v in ipairs(vaults) do
          table.insert(items, v.name)
          paths[v.name] = vim.fn.expand(v.path)
        end
        vim.ui.select(items, { prompt = 'Explore vault:' }, function(choice)
          if not choice then return end
          require('neo-tree.command').execute { action = 'close' }
          require('neo-tree.command').execute {
            dir = paths[choice],
            source = 'filesystem',
            position = 'float',
          }
        end)
      end,
      desc = '[O]bsidian [V]ault [T]ree',
    },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)

    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('obsidian-conceal', { clear = true }),
      pattern = '*.md',
      callback = function(ev)
        local file = vim.api.nvim_buf_get_name(ev.buf)
        for _, v in ipairs(vaults) do
          if file:find(vim.fn.expand(v.path), 1, true) then
            vim.wo.conceallevel = 2
            return
          end
        end
      end,
    })
  end,
}
