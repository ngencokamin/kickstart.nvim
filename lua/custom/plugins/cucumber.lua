return {
  {
    'tpope/vim-cucumber',
    ft = { 'cucumber' },
    keys = {
      {
        'grd',
        function()
          local line = vim.api.nvim_get_current_line()
          local step = line:match '^%s*Given%s+(.+)$'
            or line:match '^%s*When%s+(.+)$'
            or line:match '^%s*Then%s+(.+)$'
            or line:match '^%s*And%s+(.+)$'
            or line:match '^%s*But%s+(.+)$'
          if not step then
            vim.notify('No step text found on this line', vim.log.levels.WARN)
            return
          end
          step = step:gsub('%s+$', '')

          -- Replace quoted strings with \S+ placeholder
          local pattern = step:gsub("'[^']*'", '\\S+'):gsub('"[^"]*"', '\\S+')

          -- Replace camelCase/PascalCase/number words with \S+
          local parts = {}
          for word in pattern:gmatch '%S+' do
            if word == '\\S+' then
              table.insert(parts, '\\S+')
            elseif word:match '%l%u' or word:match '^%u%u' or word:match '^%d' then
              table.insert(parts, '\\S+')
            else
              table.insert(parts, word)
            end
          end

          -- Collapse consecutive \S+
          local collapsed = {}
          for _, p in ipairs(parts) do
            if p ~= '\\S+' or collapsed[#collapsed] ~= '\\S+' then table.insert(collapsed, p) end
          end

          local search = table.concat(collapsed, ' ')
          require('fzf-lua').grep { search = search, no_esc = true, cwd = vim.fn.getcwd() .. '/testcafe/step-definitions' }
        end,
        ft = 'cucumber',
        desc = 'Jump to step definition',
      },
    },
  },
}
