return {
  'ludovicchabant/vim-gutentags',
  init = function()
    vim.g.gutentags_ctags_executable = 'ctags'
    vim.g.gutentags_generate_on_new = true
    vim.g.gutentags_generate_on_missing = true
    vim.g.gutentags_generate_on_write = true
    vim.g.gutentags_file_list_command = 'fd --type f --extension rb'
  end,
}
