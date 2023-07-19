-- ref: https://zenn.dev/kawarimidoll/articles/19bfc63e1c218c
-- 読み込み高速化?
if vim.loader then
    vim.loader.enable()
end

-- ファイルの種類毎に設定ファイルを記述できるようにする
vim.cmd("filetype plugin indent off")

-- 基本設定
-- 参考: https://trap.jp/post/524/
-- マウス操作を有効にする
vim.opt.mouse = "a"

-- 使用可能性のある改行コードを指定
vim.opt.fileformats = { "unix", "dos", "mac" }

-- ファイル読み込むときのエンコード
-- 左から順に試す
vim.opt.fileencodings = "utf-8", "cp932", "ucs-bombs", "euc-jp"

--" 全角文字の表示に2文字分使うようにする
vim.opt.ambiwidth = "double"

-- スワップファイルを作成しないようにする
vim.opt.swapfile = false

-- :q したときにバッファを消さず隠して保持しておくようにする
vim.opt.hidden = true

-- 行番号を表示する
vim.opt.number = true

-- 空白文字を可視化する
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "*", nbsp = "+", space = "⋅" }

-- 良い感じにインデントしてくれるようにする
vim.opt.smartindent = true

-- ビープ音を画面フラッシュで代替
vim.opt.visualbell = true

-- TABキーを押したときにtab文字ではなくスペースを入力するようにする
vim.opt.expandtab = true

-- TABキーを押したときのインデントのスペース個数を指定する
vim.opt.tabstop = 4

-- 自動インデントのスペース個数を指定する
vim.opt.shiftwidth = 4

---- 検索関係の設定
-- 大文字小文字の区別をなくす
vim.opt.ignorecase = true

-- 検索単語に大文字が含まれていた場合特別な意味があると解釈させる
vim.opt.smartcase = true

-- 一番下の単語まで行ったら一番上に戻るようにさせる
vim.opt.wrapscan = true

---- lightline.vim 用
-- 常にタブページのラベル(各タブのファイル名)を表示
vim.opt.showtabline = 2

-- モードの表記を消す
vim.opt.showmode = false

--ある行の行頭から前の行の行末に移動したり, 逆に行末から次の行の行頭に移動できるようにする
-- BackSpaceキー, SPACEキーで有効になる
-- <(←キー),>(→キー)はNORMALモード及びVISUALモードで各キーにこの機能を割り当て
-- [(←キー),](→キー)はINSERTモード(置換含む)でこの機能を有効にする
vim.opt.whichwrap = "b", "s", "<", ">", "[", "]"

-- 反映時間を短くする(デフォルトは4000ms)
vim.opt.updatetime = 250

-- ヘルプ日本語化
vim.opt.helplang = "ja", "en"

-- シンタックスハイライトを有効にする
vim.cmd("syntax enable")

-- True Colorでのシンタックスハイライト
vim.opt.termguicolors = true
vim.cmd([[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]])
vim.cmd([[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]])

-- Pythonのパスを指定
vim.g.python_host_prog = "~/.asdf/shims/python2"
vim.g.python3_host_prog = "~/.asdf/shims/python3"

-- Perl Providerを無効にする
vim.g.loaded_perl_provider = 0

-- NeoVimの無名レジスタ(yでヤンクしたときにコピーする先)とOSのクリップボードを結びつける
-- 低スぺック環境ではオフにする
--vim.opt.clipboard = 'unnamedplus'

-- キーマッピング
-- ファイル上の1行が画面上では複数行にわたっているとき
-- NORMALモード時の j/kで見た目通りに移動できるようにする
-- ref:
-- https://zenn.dev/slin/articles/2020-11-03-neovim-lua2#%E3%83%9E%E3%83%83%E3%83%94%E3%83%B3%E3%82%B0
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- ESCキー連打でハイライト解除
--cmd('nmap <Esc><Esc> :nohlsearch<CR><Esc>')
vim.keymap.set("", "<Esc><Esc>", ":nohlsearch<CR><Esc>")

-- GUI VIM用の設定
--cmd('imap <S-CR> <End><CR>')
vim.keymap.set("i", "<S-CR>", "<End><CR>")
--cmd('imap <C-S-CR> <Up><End><CR>')
vim.keymap.set("i", "<C-S-CR>", "<Up><End><CR>")
vim.keymap.set("n", "<S-CR>", "mzo<ESC>`z")
vim.keymap.set("n", "<C-S-CR>", "mzO<ESC>`z")

-- Ctrl+Wを押した後にnを押すことで新規タブを開けるようにする
vim.keymap.set("n", "<C-w>n", "<Esc>:enew<Return>")

-- win32yankの設定
--cmd('nnoremap <silent> <Space>y :.w !win32yank.exe -i<CR><CR>')
vim.keymap.set("n", "<silent> <Space>y", ":.w !win32yank.exe -i<CR><CR>")
--cmd('vnoremap <silent> <Space>y :w !win32yank.exe -i<CR><CR>')
vim.keymap.set("v", "<silent> <Space>y", ":w !win32yank.exe -i<CR><CR>")
--cmd('nnoremap <silent> <Space>p :r !win32yank.exe -o<CR>')
vim.keymap.set("n", "<silent> <Space>p", ":r !win32yank.exe -o<CR>")
--cmd('vnoremap <silent> <Space>p :r !win32yank.exe -o<CR>')
vim.keymap.set("v", "<silent> <Space>p", ":r !win32yank.exe -o<CR>")

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
    -- 分類不明
    { "nvim-lua/plenary.nvim", lazy = true },
    { "rcarriga/nvim-notify", lazy = true },
    { "kkharji/sqlite.lua", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-telescope/telescope.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "lambdalisue/nerdfont.vim", lazy = true },
    { "lambdalisue/fern-git-status.vim", lazy = true },

    -- main color theme
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
    "tanvirtin/monokai.nvim",
    "Allianaab2m/penumbra.nvim",
    "folke/tokyonight.nvim",

    -- status line
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
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

    -- denops.vim
    "vim-denops/denops.vim",
    "lambdalisue/gin.vim",
    --"skanehira/denops-twihi.vim",
    "skanehira/denops-docker.vim",
    "willelz/skk-tutorial.vim",
    {
        "Omochice/dps-translate-vim",
        cmd = { "Translate", "TranslateJoin" },
        init = function()
            -- dps-translate-vim
            vim.g.dps_translate_source = "en"
            vim.g.dps_translate_target = "ja"
        end,
    },

    -- syntax hilights
    {
        "preservim/vim-markdown",
        init = function()
            -- 折りたたみ無効化
            vim.g.vim_markdown_folding_disabled = 1
            -- YAMLフロントマターの強調表示
            vim.g.vim_markdown_frontmatter = 1
        end,
    },
    "imsnif/kdl.vim",
    "cespare/vim-toml",
    "NoahTheDuke/vim-just",
    "nastevens/vim-cargo-make",
    "alker0/chezmoi.vim",

    -- nvim treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
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
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    "IndianBoy42/tree-sitter-just",

    -- coc.nvim
    {
        "neoclide/coc.nvim",
        branch = "release",
        build = ":CocUpdate",
        init = function()
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
            --)
            --vim.cmd([[
            --[[
                function! CheckBackspace() abort
                    let col = col('.') - 1
                    return !col || getline('.')[col - 1]  =~# '\s'
                endfunction
            ]]
            --)
            --vim.g.coc_snippet_next = '<tab>'
            -- coc.nvim settings
            vim.g.coc_global_extensions = {
                "coc-html",
                "coc-solargraph",
                "coc-git",
                "coc-json",
                "coc-rust-analyzer",
                "coc-snippets",
                "coc-deno",
                "coc-tsserver",
                "coc-eslint",
                "coc-css",
                "coc-jest",
                "coc-prettier",
                "coc-pyright",
            }
        end,
    },

    -- utilities
    {
        "mattn/calendar-vim",
        cmd = {
            "Calendar",
            "CalendarH",
            "CalendarT",
        },
    },
    "vim-jp/vimdoc-ja",
    {
        "dstein64/vim-startuptime",
        cmd = { "StartupTime" },
    },
    "nastevens/vim-duckscript",
    {
        "thinca/vim-scouter",
        cmd = { "Scouter", "ScouterVerbose" },
    },
    "thinca/vim-quickrun",
    {
        "airblade/vim-gitgutter",
        init = function()
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
    "godlygeek/tabular",
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    },
    "vim-skk/skkeleton",
    {
        "kode-team/mastodon.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "rcarriga/nvim-notify",
            "kkharji/sqlite.lua",
        },
        config = function()
            require("mastodon").setup({})
        end,
    },
    {
        "jackMort/ChatGPT.nvim",
        cmd = "ChatGPT",
        -- March 6th 2023, before submit issue
        commit = "8820b99c",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("chatgpt").setup({
                welcome_message = WELCOME_MESSAGE,
                loading_text = "loading",
                question_sign = "", -- you can use emoji if you want e.g. 🙂
                answer_sign = "ﮧ", -- 🤖
                max_line_length = 120,
                yank_register = "+",
                chat_layout = {
                    relative = "editor",
                    position = "50%",
                    size = {
                        height = "80%",
                        width = "80%",
                    },
                },
                settings_window = {
                    border = {
                        style = "rounded",
                        text = {
                            top = " Settings ",
                        },
                    },
                },
                chat_window = {
                    filetype = "chatgpt",
                    border = {
                        highlight = "FloatBorder",
                        style = "rounded",
                        text = {
                            top = " ChatGPT ",
                        },
                    },
                },
                chat_input = {
                    prompt = "  ",
                    border = {
                        highlight = "FloatBorder",
                        style = "rounded",
                        text = {
                            top_align = "center",
                            top = " Prompt ",
                        },
                    },
                },
                openai_params = {
                    model = "gpt-3.5-turbo",
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    max_tokens = 300,
                    temperature = 0,
                    top_p = 1,
                    n = 1,
                },
                openai_edit_params = {
                    model = "code-davinci-edit-001",
                    temperature = 0,
                    top_p = 1,
                    n = 1,
                },
                keymaps = {
                    close = { "<C-c>" },
                    submit = "<C-Enter>",
                    yank_last = "<C-y>",
                    yank_last_code = "<C-k>",
                    scroll_up = "<C-u>",
                    scroll_down = "<C-d>",
                    toggle_settings = "<C-o>",
                    new_session = "<C-n>",
                    cycle_windows = "<Tab>",
                    -- in the Sessions pane
                    select_session = "<Space>",
                    rename_session = "r",
                    delete_session = "d",
                },
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        --tag = "*",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "alanfortlink/blackjack.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- fern.vim
    {
        "lambdalisue/fern-renderer-nerdfont.vim",
        lazy = true,
        dependencies = {
            "lambdalisue/nerdfont.vim",
        },
        init = function()
            -- アイコン表示を有効にする
            -- ref: https://qiita.com/matoruru/items/b5ad6e0f1ef6c804378d#%E4%BB%98%E3%81%8D%E3%81%AE%E5%A4%89%E6%95%B0%E3%81%AB%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%81%99%E3%82%8B%E9%9A%9B%E3%81%AE%E6%B3%A8%E6%84%8F%E7%82%B9
            vim.g["fern#renderer"] = "nerdfont"
        end,
    },
    {
        "lambdalisue/glyph-palette.vim",
        lazy = true,
        dependencies = {
            "lambdalisue/nerdfont.vim",
            "lambdalisue/fern-renderer-nerdfont.vim",
        },
        init = function()
            -- アイコンに色をつける
            vim.cmd([[
                augroup my-glyph-palette
                    autocmd! *
                    autocmd FileType fern call glyph_palette#apply()
                    autocmd FileType nerdtree,startify call glyph_palette#apply()
                augroup END
            ]])
            -- ドットファイルを表示させる
            vim.g["fern#default_hidden"] = 1
        end,
    },
    {
        "https://github.com/lambdalisue/fern.vim",
        dependencies = {
            "lambdalisue/fern-git-status.vim",
            "lambdalisue/glyph-palette.vim",
            "lambdalisue/nerdfont.vim",
            "lambdalisue/fern-renderer-nerdfont.vim",
        },
        init = function()
            -- ref: https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%84%E3%83%AA%E3%83%BC%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B
            -- Ctrl+nでファイルツリーを表示/非表示する
            vim.keymap.set("n", "<C-n>", ":Fern . -reveal=% -drawer -toggle -width=40<CR>")
        end,
    },

    -- fzf-lua
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({})
        end,
        init = function()
            -- 以下はfzf.vimのもの
            -- Ctrl+pでファイル検索を開く
            -- git管理されていれば:GFiles、そうでなければ:Filesを実行する
            --[[
            vim.cmd([[
            fun! FzfOmniFiles()
                let is_git = system('git status')
                if v:shell_error
                    files
                else
                    git_files
                endif
            endfun
            ]]
            --)
            --vim.keymap.set("n", "<C-p>", ":call FzfOmniFiles()<CR>")

            -- Ctrl+gで文字列検索を開く
            -- <S-?>でプレビューを表示/非表示する
            --[[
            vim.cmd([[
            command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
            \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
            \ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
            \ <bang>0)
            ]]
            --)
            --vim.keymap.set("n", "<C-g>", ":Rg<CR>")

            -- frでカーソル位置の単語をファイル検索する
            --vim.keymap.set("n", "fr", 'vawy:Rg <C-R>"<CR>')

            -- frで選択した単語をファイル検索する
            --vim.keymap.set("x", "fr y", ':Rg <C-R>"<CR>')

            -- fbでバッファ検索を開く
            --vim.keymap.set("n", "fb", ":Buffers<CR>")

            -- fpでバッファの中で1つ前に開いたファイルを開く
            --vim.keymap.set("n", "fp", ":Buffers<CR><CR>")

            -- flで開いているファイルの文字列検索を開く
            --vim.keymap.set("n", "fl", ":BLines<CR>")

            -- fmでマーク検索を開く
            --vim.keymap.set("n", "fm", ":Marks<CR>")

            -- fhでファイル閲覧履歴検索を開く
            --vim.keymap.set("n", "fh", ":History<CR>")

            -- fcでコミット履歴検索を開く
            --vim.keymap.set("n", "fc", ":Commits<CR>")
        end,
    },
})

vim.cmd("filetype plugin indent on")
