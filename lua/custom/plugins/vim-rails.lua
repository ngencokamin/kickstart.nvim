return {
    {
        -- https://github.com/tpope/vim-rails
        "tpope/vim-rails"
    },
    {
        -- https://github.com/tpope/vim-bundler
        "tpope/vim-bundler"
    },
    {
        -- https://github.com/tpope/vim-dispatch
        "tpope/vim-dispatch"
    },
    {
        -- https://github.com/andrewRadev/rails_extra.vim
        'AndrewRadev/rails_extra.vim',
        dependencies = {
            "tpope/vim-rails", -- makes sure that this loads after Neo-tree.
        },
    }
}