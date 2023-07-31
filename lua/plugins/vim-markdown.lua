return {
    "preservim/vim-markdown",
    ft = {
        "markdown",
    },
    dependencies = {
        {
            "godlygeek/tabular",
        },
    },
    config = function()
        -- vim-markdown
        -- 折りたたみ無効化
        vim.g.vim_markdown_folding_disabled = 1

        -- YAMLフロントマターの強調表示
        vim.g.vim_markdown_frontmatter = 1
    end,
}
