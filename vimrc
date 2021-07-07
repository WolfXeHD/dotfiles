" ThingsToInvestigate {{{
" Plugins:
"   check out the implementation of some plugins
"   Plug 'tenfyzhong/CompleteParameter.vim'
"   Plug 'wellle/targets.vim'
"   check out ReplaceWithRegister plugin
"   checkout brooth/far.vim
" }}}
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"VimPlug {{{
call plug#begin()

Plug 'Raimondi/delimitMate'
Plug 'konpa/devicon'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ivalkeen/nerdtree-execute'
" Plug 'ervandew/supertab'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format', { 'for': ['cpp', 'cxx'] }
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'bronson/vim-trailing-whitespace'
Plug 'majutsushi/tagbar', { 'for': ['cpp', 'cxx'] }
Plug 'altercation/vim-colors-solarized'
Plug 'goerz/jupytext.vim'

let s:darwin = has('mac')
"
if s:darwin
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'commit': '3c07232'}
endif
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Plug 'davidhalter/jedi'
Plug 'pearofducks/ansible-vim'

Plug 'lervag/vimtex', { 'for': ['tex'] }
Plug 'gioele/vim-autoswap'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
" Plug 'rhysd/vim-grammarous'
Plug 'junegunn/goyo.vim'

Plug 'shime/vim-livedown'
Plug 'Ben201310/online-thesaurus-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'vimwiki/vimwiki', { 'on': 'VimwikiIndex' }


call plug#end()

" }}}
" vimsettings {{{
filetype plugin indent on
syntax on
set hidden
set list
set listchars=tab:▸\ ,eol:¬
set foldmethod=marker
set cursorline
set conceallevel=0
let g:deoplete#enable_at_startup = 1

" tabs
set tabstop=2       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.

set ruler           " sets the line numbers
set relativenumber
set number
set lazyredraw      " cures the slow redrawing of line numbers when relative number is used (at least partially)
noremap % v%

function! BgToggleSol()
    if (&background == "light")
        set background=dark
    else
        set background=light
    endif
endfunction
nnoremap <silent> <leader>dd :call BgToggleSol()<cr>
colorscheme solarized

set laststatus=2
set wildmenu
set hlsearch
set incsearch
set backspace=indent,eol,start
set background=dark
set guitablabel+=\ %N
" set clipboard=unnamed

" searching
set ignorecase      " case insensitive searching
set smartcase       " case-sensitive if expresson contains a capital letter

" font
set encoding=utf8
set guifont=FiraCode-Retina:h12
set shellslash
set grepprg=grep\ -nH\ $*

hi clear SpellBad
hi SpellBad cterm=underline,bold

nnoremap / :noh<cr>:call clearmatches()<cr>/\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" }}}
" Functions and corresponding remappings {{{
" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

fu! SaveSess()
  execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
  if argc() == 0
    if filereadable(getcwd() . '/.session.vim')
      execute 'so ' . getcwd() . '/.session.vim'
      if bufexists(1)
        for l in range(1, bufnr('$'))
          if bufwinnr(l) == -1
            exec 'sbuffer ' . l
          endif
        endfor
      endif
    endif
  endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd BufEnter *.png,*.jpg,*gif,*pdf exec "! open ".expand("%") | :bw
nnoremap <silent> <leader>y :0,$!yapf <cr>
" autocmd VimEnter * nested call RestoreSess()
" autocmd FileType tex :set norelativenumber

set sessionoptions-=options  " Don't save options


" Sorts numbers in ascending order.
" Examples:
" [2, 3, 1, 11, 2] --> [1, 2, 2, 3, 11]
" ['2', '1', '10','-1'] --> [-1, 1, 2, 10]
function! Sorted(list)
  " Make sure the list consists of numbers (and not strings)
  " This also ensures that the original list is not modified
  let nrs = ToNrs(a:list)
  let sortedList = sort(nrs, "NaturalOrder")
  echo sortedList
  return sortedList
endfunction

" Comparator function for natural ordering of numbers
function! NaturalOrder(firstNr, secondNr)
  if a:firstNr < a:secondNr
    return -1
  elseif a:firstNr > a:secondNr
    return 1
  else
    return 0
  endif
endfunction

" Coerces every element of a list to a number. Returns a new list without
" modifying the original list.
function! ToNrs(list)
  let nrs = []
  for elem in a:list
    let nr = 0 + elem
    call add(nrs, nr)
  endfor
  return nrs
endfunction

function! WordFrequency() range
  " Words are separated by whitespace or punctuation characters
  let wordSeparators = '[[:blank:][:punct:]]\+'
  let allWords = split(join(getline(a:firstline, a:lastline)), wordSeparators)
  let wordToCount = {}
  for word in allWords
    let wordToCount[word] = get(wordToCount, word, 0) + 1
  endfor

  let countToWords = {}
  for [word,cnt] in items(wordToCount)
    let words = get(countToWords,cnt,"")
    " Append this word to the other words that occur as many times in the text
    let countToWords[cnt] = words . " " . word
  endfor

  " Create a new buffer to show the results in
  new
  setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20

  " List of word counts in ascending order
  let sortedWordCounts = Sorted(keys(countToWords))

  call append("$", "count \t words")
  call append("$", "--------------------------")
  " Show the most frequent words first -> Descending order
  for cnt in reverse(sortedWordCounts)
    let words = countToWords[cnt]
    call append("$", cnt . "\t" . words)
  endfor
endfunction
command! -range=% WordFrequency <line1>,<line2>call WordFrequency()

set encoding=utf-8

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let l:temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = l:temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" vnoremap p "0p " this needs to be more refined!

" }}}
" Nerdtree settings {{{
let g:NERDTreeShowBookmarks=1
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

"Close NERDTree if it is the last open buffer
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction


" }}}
" Custom mappings {{{
map <leader>n :NERDTreeToggle <CR>
map <leader>rc :e ~/.vimrc <CR>
map <leader>f :Files <CR>
map <leader>b :Buffers <CR>
map <leader>l :Lines <CR>
noremap ; :
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>
" Fast saving
nmap <leader>w :w!<cr>

map <leader>k :ThesaurusCurrent <CR>
" What does that do?
map <leader><leader>d :s/\(\<\w\+\>\)\_s*\<\1\><CR>

" disable arrowkeys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" don't loose focus for n,N,*
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * m1viw*<esc>`1
" nnoremap <F5> :GundoToggle<CR>
" To open a new empty buffer
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>
set pastetoggle=<F2>

" additional escape
inoremap jj <Esc>

" qq to record, Q to replay
nnoremap Q @q

" copy and paste
vmap <C-c> "*yi
vmap <C-x> "*c
vmap <C-v> c<ESC>"*p
imap <C-v> <ESC>"*pa

" }}}
" YCM and UltiSnips {{{
" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_csharp_insert_namespace_expr = ''

let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger = '<s-tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-q>'
let g:UltiSnipsEditSplit = 'vertical'
" }}}
" Airline, Peekaboo, fzf settings {{{
" Prefix for the peekaboo key mapping (default: '')
" let g:peekaboo_prefix = '<leader>'

" airline settings
let g:airline_theme = 'tomorrow'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
" let g:airline#themes#solarized#palette = {}

" fzf settings
let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
set runtimepath+=~/.fzf
set runtimepath+=/usr/local/opt/fzf

" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
" the browser to use
let g:livedown_browser = "chrome"

" markdown with grip
let g:vim_markdown_preview_github=1
" }}}
" Latex settings {{{
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer
      \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
let g:vimtex_quickfix_mode=0
let g:tex_flavor='latex'
function! UpdateSkim(status)
  if !a:status | return | endif
  let l:out = b:vimtex.out()
  let l:tex = expand('%:p')
  let l:cmd = [g:vimtex_view_general_viewer, '-r']
  if !empty(system('pgrep Skim'))
    call extend(l:cmd, ['-g'])
  endif
  if has('nvim')
    call jobstart(l:cmd + [line('.'), l:out, l:tex])
  elseif has('job')
    call job_start(l:cmd + [line('.'), l:out, l:tex])
  else
    call system(join(l:cmd + [line('.'),
          \ shellescape(l:out), shellescape(l:tex)], ' '))
  endif
endfunction

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

let g:ycm_semantic_triggers.tex = [
    \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
    \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
    \ 're!\\hyperref\[[^]]*',
    \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
    \ 're!\\(include(only)?|input){[^}]*',
    \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
    \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\usepackage(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
    \ 're!\\[A-Za-z]*',
    \ ]

" }}}
" DokuWiki {{{
" looks for DokuWiki headlines in the first 20 lines
" of the current buffer
fun IsDokuWiki()
  if match(getline(1,20),'^ \=\(=\{2,6}\).\+\1 *$') >= 0
    set textwidth=0
    set wrap
    set linebreak
    set filetype=dokuwiki
  endif
endfun

" check for dokuwiki syntax
autocmd BufWinEnter *.txt call IsDokuWiki()

" Include DokuVimKi Configuration
if filereadable($HOME."/.vim/dokuvimkirc")
  source $HOME/.vim/dokuvimkirc
endif

syntax on
" }}}
" CoC {{{
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-pyright', 'coc-sh']

"}}}
" Tree-Sitter (from Stefan) {{{
"
" return function()
"   local has = config_utils.has
"
"   vim.cmd [[highlight link TSKeyword Statement]]
"   vim.cmd [[highlight TSParameter gui=italic,bold]]
"
"   -- This plugin is an experimental application of tree sitter usage in Neovim
"   -- be careful when applying any functionality to a filetype as it might not work
"   local disabled = {"json"}
"
"   require "nvim-treesitter.configs".setup {
"     ensure_installed = "maintained",
"     highlight = {
"       enable = true,
"       disable = disabled
"     },
"     incremental_selection = {
"       enable = true,
"       keymaps = {
"         -- mappings for incremental selection (visual mappings)
"         init_selection = "g<enter>", -- maps in normal mode to init the node/scope selection
"         node_incremental = "g<enter>", -- increment to the upper named parent
"         scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
"         node_decremental = "grm" -- decrement to the previous node
"       }
"     },
"     rainbow = {
"       enable = true,
"     },
"
"     textobjects = {
"       select = {
"         enable = true,
"         keymaps = {
"           ["af"] = "@function.outer",
"           ["if"] = "@function.inner",
"           ["ac"] = "@class.outer",
"           ["ic"] = "@class.inner",
"         },
"       },
"     },
"   }
"
" end
"
" use {
"   "nvim-treesitter/nvim-treesitter",
"   run = ":TSUpdate",
"   config = require("config.plugins.treesitter"),
"   requires = {
"     {"p00f/nvim-ts-rainbow"},
"     {"nvim-treesitter/nvim-treesitter-textobjects"},
"   }
" }
"}}}
