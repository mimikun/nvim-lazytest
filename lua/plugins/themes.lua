return {
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,

        --cond = false,
        config = function()
            require("github-theme").setup({})
            vim.cmd.colorscheme("github_dark")
        end,
    },
    {
        "tanvirtin/monokai.nvim",
        --lazy = false,
        --priority = 1000,

        cond = false,
        config = function()
            require("monokai").setup({})
            vim.cmd.colorscheme("monokai")
        end,
    },
    {
        "Allianaab2m/penumbra.nvim",
        --lazy = false,
        --priority = 1000,

        cond = false,
        config = function()
            require("penumbra").setup({})
            vim.cmd.colorscheme("penumbra")
        end,
    },
    {
        "folke/tokyonight.nvim",
        --lazy = false,
        --priority = 1000,

        cond = false,
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    {
        "kihachi2000/yash.nvim",
        --lazy = false,
        --priority = 1000,

        cond = false,
        config = function()
            vim.cmd.colorscheme("yash")
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        --lazy = false,
        --priority = 1000,

        cond = false,
        config = function()
            vim.cmd.colorscheme("nightfox")
        end,
    },
}
