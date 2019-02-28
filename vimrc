" ThingsToInvestigate {{{
" Plugins:
"   check out the implementation of some plugins
"   Plug 'tenfyzhong/CompleteParameter.vim'
"   Plug 'wellle/targets.vim'
"   check out ReplaceWithRegister plugin
"   checkout brooth/far.vim
" }}}
"VimPlug {{{
call plug#begin()

Plug 'Raimondi/delimitMate'
Plug 'konpa/devicon'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ivalkeen/nerdtree-execute'
Plug 'ervandew/supertab'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format', { 'for': ['cpp', 'cxx'] }
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'bronson/vim-trailing-whitespace'
Plug 'majutsushi/tagbar', { 'for': ['cpp', 'cxx'] }
Plug 'altercation/vim-colors-solarized'

Plug 'Valloric/YouCompleteMe'
Plug 'davidhalter/jedi'
Plug 'pearofducks/ansible-vim'

Plug 'w0rp/ale'
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

function! HiInterestingWord(n)
    " Save our location.
    normal! mz
    " Yank the current word into the z register.
    normal! "zyiw
    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let l:mid = 86750 + a:n
    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(l:mid)
    " Construct a literal pattern that has to match at boundaries.
    let l:pat = '\V\<' . escape(@z, '\') . '\>'
    " Actually match the words.
    call matchadd('InterestingWord' . a:n, l:pat, 1, l:mid)
    " Move back to our original location.
    normal! `z
endfunction

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

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

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
nnoremap * *<c-o>
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
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'vertical'
" }}}
" Ale-settings {{{
" let statusline=%{ALEGetStatusLine()}
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = {
    \   'python': ['flake8'],
    \   'c++': ['clang'],
    \   'YAML': ['yamllint'],
    \   'bash': ['shellcheck'],
    \   'vim': ['vint']
    \}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_python_flake8_options='--ignore=E501'
let g:ale_cpp_gcc_options='-std=c++14 -Wall'
let g:ale_sign_column_always = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_tex_chktex_options='--nowarn'

let g:ale_keep_list_window_open = 1

" works on my mac! (had to remove the "_wrap" suffix - stoomboot not sure
map <silent> [x <Plug>(ale_previous)
map <silent> ]x <Plug>(ale_next)
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
" Abbreviations {{{
iabbrev @@    tim.michael.heinz.wolf@cern.ch
" }}}
