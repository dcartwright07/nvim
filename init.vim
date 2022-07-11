call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yaegassy/coc-volar', {'do': 'yarn install --frozen-lockfile'}
Plug 'yaegassy/coc-volar-tools', {'do': 'yarn install --frozen-lockfile'}

" Appearance
Plug 'patstockwell/vim-monokai-tasty'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'leafOfTree/vim-vue-plugin'
Plug 'lepture/vim-velocity'

" Version Control: Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'albanm/vuetify-vim'
Plug 'sheerun/vim-polyglot'
Plug 'rizzatti/dash.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File Explorer
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" Basics
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'alvan/vim-closetag'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}

call plug#end()

let mapleader = " " 

" Colorscheme
let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty
syntax enable
:highlight Search guibg=guibg guifg=guifg gui=italic,underline,bold

" ----- Mappings -----

" Center my searches to middle of the screen
nnoremap n nzzzv
nnoremap N Nzzzv

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> sp :CocCommand volar.action.splitEditors<cr>
command! -nargs=0 P :CocCommand prettier.forceFormatDocument

" Git Diff Checker
nnoremap <silent> <leader>[ :DiffviewOpen<cr>
nnoremap <silent> <leader>] :DiffviewClose<cr>
nnoremap <silent> <leader>\ :DiffviewFileHistory<cr>

" Buffer
nnoremap <silent> <leader>w :bd<cr>

" Commenting
nmap <silent> <leader>/ <Plug>CommentaryLine
xmap <silent> <leader>/ <Plug>Commentary

" Line moving
nnoremap <A-Up> :m-2<CR>==
nnoremap <A-Down> :m+<CR>==
inoremap <A-Up> <Esc>:m-2<CR>==gi
inoremap <A-Down> <Esc>:m+<CR>==gi
vnoremap <A-Up> :m '<-2<CR>gv=gv
vnoremap <A-Down> :m '>+1<CR>gv=gv

" Dash
nmap <silent> <leader>h <Plug>DashSearch

" Plug
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pc :PlugClean<CR>

set encoding=utf-8
set completeopt=menu,menuone,noselect " better autocomplete options
set splitright " splits to the right
set splitbelow " splits below
set expandtab " space characters instead of tab
set autoindent
set smartindent
set tabstop=2 " tab equals 2 spaces
set shiftwidth=2 " indentation
set number " show absolute line numbers
set ignorecase " search case insensitive
set smartcase " search via smartcase
set incsearch " search incremental
set diffopt+=vertical " starts diff mode in vertical split
set hidden " allow hidden buffers
set nobackup " don't create backup files
set nowritebackup " don't create backup files
set cmdheight=1 " only one line for commands
set shortmess+=c " don't need to press enter so often
set signcolumn=yes " add a column for sings (e.g. LSP, ...)
set updatetime=520 " time until update
set undofile " persists undo tree
set clipboard=unnamed
set guicursor=a:hor20-Cursor
set cursorline

autocmd BufNewFile,BufRead *.jsw set syntax=javascript
au BufNewFile,BufRead *.vm,*.vtl,*.shtml,*.stm set ft=velocity
filetype plugin indent on " enable detection, plugins and indents
if (has("termguicolors"))
  set termguicolors " better colors, but makes it sery slow!
endif

" ----- Configuration --------------------------------

" COC
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-css',
\ 'coc-eslint',
\ 'coc-prettier',
\ 'coc-vue',
\ 'coc-tsserver',
\ 'coc-vetur'
\ ]

" VueJS
let g:vim_vue_plugin_config = {
\'syntax': {
\  'template': ['html'],
\  'script': ['javascript'],
\  'style': ['scss'],
\},
\'full_syntax': [],
\'initial_indent': [],
\'attribute': 0,
\'keyword': 0,
\'foldexpr': 0,
\'debug': 0,
\}

" Example: set local options based on syntax
function! OnChangeVueSyntax(syntax)
  " echom 'Syntax is '.a:syntax
  if a:syntax == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:syntax =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction

" NERDTree
let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeWinSize = 50
let g:NERDTreeQuitOnOpen = 1
let NERDTreeDirArrowExpandable=" "
let NERDTreeDirArrowCollapsible=" "
let g:NERDTreeIgnore = ['^node_modules$', '^vendor$']

let g:netrw_banner=0 " disable banner in netrw
let g:netrw_liststyle=3 " tree view in netrw
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript'] " syntax highlighting in markdown

" Prettier
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat = 1
let g:prettier#config#single_quote = get(g:,'prettier#config#single_quote', 'true')
let g:prettier#config#semi = get(g:,'prettier#config#semi', 'false')

" Signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" Airline
let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_monokai'
let g:airline#extensions#tabline#buffer_min_count = 2

let g:vue_pre_processors = ['scss']
let g:closetag_filetypes = 'html,xhtml,phtml,vue'

" let g:javascript_conceal_function             = "ƒ"
" let g:javascript_conceal_null                 = "ø"
" let g:javascript_conceal_this                 = "@"
" let g:javascript_conceal_return               = "↵"
" let g:javascript_conceal_undefined            = "¿"
" let g:javascript_conceal_NaN                  = "ℕ"
" let g:javascript_conceal_prototype            = "¶"
" let g:javascript_conceal_static               = "•"
" let g:javascript_conceal_super                = "Ω"

" let g:typescript_conceal_function             = "ƒ"
" let g:typescript_conceal_null                 = "ø"
" let g:typescript_conceal_undefined            = "¿"
" let g:typescript_conceal_this                 = "@"
" let g:typescript_conceal_return               = "↵"
" let g:typescript_conceal_prototype            = "¶"
" let g:typescript_conceal_super                = "Ω"


try
" == Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <Down>
  \ <Plug>(denite_filter_update)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Custom options for Denite
"   split                       - Use floating window for Denite
"   start_filter                - Start filtering on default
"   auto_resize                 - Auto resize the Denite window height automatically.
"   source_names                - Use short long names if multiple sources
"   prompt                      - Customize denite prompt
"   highlight_matched_char      - Matched characters highlight
"   highlight_matched_range     - matched range highlight
"   highlight_window_background - Change background group in floating window
"   highlight_filter_background - Change background group in floating filter window
"   winrow                      - Set Denite filter window to top
"   vertical_preview            - Open the preview window vertically

let s:denite_options = {'default' : {
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" ------ ToggleTerm Settings -----
" set
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><c-`> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-`> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

lua << EOF
require("toggleterm").setup {
  direction = 'tab'
}
EOF
