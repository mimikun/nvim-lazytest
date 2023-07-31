return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" }
    },
    cond = false,
    config = function()
        require("dashboard").setup({
            -- https://github.com/nvimdev/dashboard-nvim
        })
    end,
}
