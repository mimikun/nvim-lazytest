-- Lazy.nvimでのプラグイン管理
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- color theme
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            require("github-theme").setup({})
            vim.cmd("colorscheme github_dark")
        end,
    },

    -- other color theme
    { "tanvirtin/monokai.nvim" },
    { "Allianaab2m/penumbra.nvim" },
    { "folke/tokyonight.nvim" },
    { "kihachi2000/yash.nvim" },
    { "EdenEast/nightfox.nvim" },

    ---- denops.vim
    { "vim-denops/denops.vim" },
    { "lambdalisue/gin.vim" },
    { "skanehira/denops-docker.vim" },
    { "vim-skk/skkeleton" },
    { "willelz/skk-tutorial.vim" },
    {
        "Omochice/dps-translate-vim",
        cmd = {
            "Translate",
        },
        config = function()
            -- dps-translate-vim
            vim.g.dps_translate_source = "en"
            vim.g.dps_translate_target = "ja"
        end,
    },

    -- status line
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        config = function()
            -- lualine.nvim
            --ref:
            --https://raw.githubusercontent.com/numToStr/dotfiles/master/neovim/.config/nvim/lua/numToStr/plugins/lualine.lua
            require("lualine").setup({
                options = {
                    theme = "auto",
                    component_separators = "",
                    section_separators = "",
                    icons_enabled = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = {
                        { "mode", color = { gui = "bold" } },
                    },
                    lualine_b = {
                        { "branch" },
                        { "diff", colored = false },
                    },
                    lualine_c = {
                        { "filename", file_status = true },
                        { "diagnostics" },
                    },
                    lualine_x = {
                        "filetype",
                        "encoding",
                        "fileformat",
                    },
                    lualine_y = { "progress" },
                    lualine_z = {
                        { "location", color = { gui = "bold" } },
                    },
                },
                tabline = {
                    lualine_a = {
                        {
                            "buffers",
                            buffers_color = { active = "lualine_b_normal" },
                        },
                    },
                    lualine_z = {
                        {
                            "tabs",
                            tabs_color = { active = "lualine_b_normal" },
                        },
                    },
                },
            })
        end,
    },

    -- utilities
    { "vim-jp/vimdoc-ja" },
    {
        "mattn/calendar-vim",
        cmd = {
            "Calendar",
        },
    },
    {
        "thinca/vim-scouter",
        cmd = {
            "Scouter",
        },
    },
    {
        -- https://github.com/is0n/jaq-nvim にしたい
        "thinca/vim-quickrun",
        cmd = {
            "QuickRun",
        },
    },
    {
        "dstein64/vim-startuptime",
        cmd = {
            "StartupTime",
        },
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        "kode-team/mastodon.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "rcarriga/nvim-notify" },
            { "kkharji/sqlite.lua" },
        },
        cmd = {
            "MastodonTootMessage",
            "MastodonAddAccount",
            "MastodonSelectAccount",
            "MastodonLoadHomeTimeline",
            "MastodonLoadBookmarks",
            "MastodonLoadFavourites",
            "MastodonLoadReplies",
            "MastodonReload",
        },
        config = function()
            require("mastodon").setup({})
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    {
        "airblade/vim-gitgutter",
        config = function()
            -- vim-gitgutter
            -- g]で前の変更箇所へ移動する
            vim.keymap.set("n", "g[", ":GitGutterPrevHunk<CR>")

            -- g[で次の変更箇所へ移動する
            vim.keymap.set("n", "g]", ":GitGutterNextHunk<CR>")

            -- ghでdiffをハイライトする
            vim.keymap.set("n", "gh", ":GitGutterLineHighlightsToggle<CR>")

            -- gpでカーソル行のdiffを表示する
            vim.keymap.set("n", "gp", ":GitGutterPreviewHunk<CR>")

            -- 記号の色を変更する
            vim.cmd([[highlight GitGutterAdd ctermfg=green]])
            vim.cmd([[highlight GitGutterChange ctermfg=blue]])
            vim.cmd([[highlight GitGutterDelete ctermfg=red]])
        end,
    },

    -- syntax hilights
    { "imsnif/kdl.vim" },
    { "NoahTheDuke/vim-just" },
    { "alker0/chezmoi.vim" },
    {
        "nastevens/vim-cargo-make",
        dependencies = {
            { "cespare/vim-toml" },
            { "nastevens/vim-duckscript" },
        },
    },
    {
        "preservim/vim-markdown",
        dependencies = {
            { "godlygeek/tabular" },
        },
        config = function()
            -- vim-markdown
            -- 折りたたみ無効化
            vim.g.vim_markdown_folding_disabled = 1

            -- YAMLフロントマターの強調表示
            vim.g.vim_markdown_frontmatter = 1
        end,
    },

    -- coc.nvim
    {
        "neoclide/coc.nvim",
        branch = "release",
        build = ":CocUpdate",
        config = function()
            -- coc.nvim settings
            -- <tab> と<Shift-tab> でナビゲートするやつ
            vim.cmd([[
                function! CheckBackspace() abort
                    let col = col('.') - 1
                    return !col || getline('.')[col - 1]  =~ '\s'
                endfunction
            ]])

            -- Insert <tab> when previous text is space, refresh completion if not.
            vim.cmd([[
                inoremap <silent><expr> <TAB>
                    \ coc#pum#visible() ? coc#pum#next(1):
                    \ CheckBackspace() ? "\<Tab>" :
                    \ coc#refresh()
            ]])
            vim.cmd([[inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]])

            -- VSCodeライクなタブ補完
            --vim.cmd([[
            --[[
            inoremap <silent><expr> <TAB>
                \ coc#pum#visible() ? coc#_select_confirm() :
                \ coc#expandableOrJumpable() ?
                \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
                \ CheckBackspace() ? "\<TAB>" :
                \ coc#refresh()
            ]]
            --]])
            --vim.cmd([[
            --[[
            function! CheckBackspace() abort
                let col = col('.') - 1
                return !col || getline('.')[col - 1]  =~# '\s'
            endfunction
            ]]
            --]])
            --vim.g.coc_snippet_next = '<tab>'

            -- coc.nvim settings
            vim.g.coc_global_extensions = {
                "coc-css",
                "coc-deno",
                "coc-eslint",
                "coc-git",
                "coc-html",
                "coc-jest",
                "coc-json",
                "coc-prettier",
                "coc-pyright",
                "coc-rust-analyzer",
                "coc-snippets",
                "coc-solargraph",
                "coc-tsserver",
                "coc-yaml",
                "coc-zls",
            }
        end,
    },

    -- fern.vim
    {
        "lambdalisue/fern.vim",
        branch = "main",
        dependencies = {
            { "lambdalisue/fern-git-status.vim" },
            { "lambdalisue/nerdfont.vim" },
            { "lambdalisue/fern-renderer-nerdfont.vim" },
            { "lambdalisue/glyph-palette.vim" },
        },
        event = "UIEnter",
        config = function()
            -- fern.vim settings
            -- ref: https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%84%E3%83%AA%E3%83%BC%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B
            -- Ctrl+nでファイルツリーを表示/非表示する
            vim.keymap.set("n", "<C-n>", ":Fern . -reveal=% -drawer -toggle -width=40<CR>")

            -- アイコン表示を有効にする
            -- ref: https://qiita.com/matoruru/items/b5ad6e0f1ef6c804378d#%E4%BB%98%E3%81%8D%E3%81%AE%E5%A4%89%E6%95%B0%E3%81%AB%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%81%99%E3%82%8B%E9%9A%9B%E3%81%AE%E6%B3%A8%E6%84%8F%E7%82%B9
            vim.g["fern#renderer"] = "nerdfont"

            -- アイコンに色をつける
            vim.api.nvim_create_augroup("my_glyph_palette", {})
            vim.api.nvim_create_autocmd("FileType", {
                group = "my_glyph_palette",
                pattern = "fern",
                command = "call glyph_palette#apply()",
            })
            vim.api.nvim_create_autocmd("FileType", {
                group = "my_glyph_palette",
                pattern = { "nerdtree", "startify" },
                command = "call glyph_palette#apply()",
            })

            -- ドットファイルを表示させる
            vim.g["fern#default_hidden"] = 1
        end,
    },

    -- fzf.vim
    {
        "junegunn/fzf.vim",
        dependencies = {
            { "junegunn/fzf" },
        },
        config = function()
            -- fzf.vim
            -- Ctrl+pでファイル検索を開く
            -- git管理されていれば:GFiles、そうでなければ:Filesを実行する
            vim.cmd([[
                fun! FzfOmniFiles()
                    let is_git = system('git status')
                    if v:shell_error
                        :Files
                    else
                        :GFiles
                    endif
                endfun
            ]])

            vim.keymap.set("n", "<C-p>", ":call FzfOmniFiles()<CR>")

            -- Ctrl+gで文字列検索を開く
            -- <S-?>でプレビューを表示/非表示する
            vim.cmd([[
                command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
                \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
                \ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
                \ <bang>0)
            ]])

            vim.keymap.set("n", "<C-g>", ":Rg<CR>")

            -- frでカーソル位置の単語をファイル検索する
            vim.keymap.set("n", "fr", 'vawy:Rg <C-R>"<CR>')

            -- frで選択した単語をファイル検索する
            --cmd([[xnoremap fr y:Rg <C-R>"<CR>]])
            vim.keymap.set("x", "fr y", ':Rg <C-R>"<CR>')

            -- fbでバッファ検索を開く
            vim.keymap.set("n", "fb", ":Buffers<CR>")

            -- fpでバッファの中で1つ前に開いたファイルを開く
            vim.keymap.set("n", "fp", ":Buffers<CR><CR>")

            -- flで開いているファイルの文字列検索を開く
            vim.keymap.set("n", "fl", ":BLines<CR>")

            -- fmでマーク検索を開く
            vim.keymap.set("n", "fm", ":Marks<CR>")

            -- fhでファイル閲覧履歴検索を開く
            vim.keymap.set("n", "fh", ":History<CR>")

            -- fcでコミット履歴検索を開く
            vim.keymap.set("n", "fc", ":Commits<CR>")
        end,
    },

    -- nvim treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            -- nvim-treesitter config
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    disable = {},
                },
                ensure_installed = {
                    "bash",
                    "c",
                    "c_sharp",
                    "cmake",
                    "cpp",
                    "css",
                    "dockerfile",
                    "fish",
                    "go",
                    "gomod",
                    "gowork",
                    "html",
                    "java",
                    "javascript",
                    "jsdoc",
                    "json",
                    "json5",
                    "latex",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "ninja",
                    "nix",
                    "ocaml",
                    "ocaml_interface",
                    "python",
                    "regex",
                    "rst",
                    "ruby",
                    "rust",
                    "scss",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vue",
                    "yaml",
                },
            })
        end,
    },
    { "IndianBoy42/tree-sitter-just" },
})
