execute pathogen#infect()

set nocompatible
filetype off

so ~/.vim/custom_functions.vim
"===============================================================================
" Basic Settings                                                             {{{
"===============================================================================
set encoding=utf-8
set autoindent      " automtically indent to current line
set expandtab       " replace tabs with spaces
set tabstop=4       " ... with four spaces
set shiftwidth=4    " ... and do the same for > and <
set history=500     " keep 500 lines in history
set directory=~/.vim/swapfiles  " keep swap files in ~/.vim/swapfiles
set noesckeys       " disables the delay when hitting escape
set foldmethod=marker
set foldlevel=99
set wildignore+=*.hi,*.o*.so,*.swp,*.zip,*.jpg,*.png,*.gif,*.pyc  " ignore patterns for ctrlp
set wildmenu
set splitright splitbelow
set shell=/bin/zsh
set matchpairs+=<:>
set ignorecase
set smartcase
set spelllang=en,de
filetype plugin on                      " use the filetype plugin
let Tlist_Use_Right_Window = 1          " open tlist on the right
let Tlist_GainFocus_On_ToggleOpen = 1   " focus tlist on first open
let Tlist_Close_On_Select = 1           " exit vim when only the tlist window is opened
let Tlist_Exit_OnlyWindow = 1           " exit vim when only the tlist window is opened
let g:ctrlp_working_path_mode = 2
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
let g:table_mode_toggle_map = "q"
let g:user_zen_expandabbr_key='<C-y>,'
let g:EasyMotion_leader_key = '<space>'


"============================================================================}}}
" Look                                                                       {{{
"===============================================================================
set number          " show line numbers
syntax on           " enable syntax highlighting
set nohlsearch      " don't highlight search matches
set cursorline      " highlight the current line
set t_Co=256        " use 256 colors
set list listchars=tab:»·,trail:·

" let g:hybrid_user_xresources = 1
" colorscheme hybrid   " solarized colorscheme
" let g:solarized_termcolors=256
set background=dark
" if has("gui_running")
"     set background=light
" endif
colorscheme solarized   " solarized colorscheme
" let g:Powerline_symbols = 'fancy'   " Powerline arrows (requires patched font)
set laststatus=2    " always show status bar
set guifont=Inconsolata\ 13

"============================================================================}}}
" Autocmds                                                                   {{{
"===============================================================================
" Filetype Indent 
augroup filetypes
    autocmd!
    autocmd FileType php set ai sw=2 sts=2 et   " indent php with 2 spaces
    autocmd FileType ruby set ai sw=2 sts=2 et   " indent php with 2 spaces
    autocmd FileType lisp set ai sw=2 sts=2 et
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null     " indent xml with =
    autocmd BufEnter *.hy set filetype=lisp
augroup END


augroup templates
    autocmd!
    autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/'.expand("<afile>:e").'.template' | normal Gddgg
augroup END

"============================================================================}}}
" Plugin-specific Configuration                                              {{{
"===============================================================================
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

"============================================================================}}}
" Key Configuration                                                          {{{
"===============================================================================
" Tab and Split Management                                                   {{{
"-------------------------------------------------------------------------------
let mapleader='t'
map <leader>n :tabnew<cr>
map <leader>c :tabclose<cr>
map <leader>t :tabnext<cr>
map <leader>T :tabprevious<cr>
map <leader>p :CtrlPBuffer<cr>
map <leader>m :tabmove 
map <leader>f :tabfirst<cr>
map <leader>l :tablast<cr>
map <leader>o :tabonly<cr>
map <leader>e :tabedit <c-r>=expand("%:p:h")<cr><cr>
map <C-W>u :call MergeTabs()<cr>
map <C-W><C-U> :call MergeTabs()<cr>
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <F1> :ls<cr>:b 
let mapleader=','
nnoremap <leader>sp :sp<cr>
nnoremap <leader>v :vsp<cr>
nnoremap <leader>b :ls<cr>:b 

" View buffer in two columns
nnoremap <leader>u gg:vsp<cr>Ljzt:set scrollbind<cr><C-W>h:set scrollbind<cr>

"----------------------------------------------------------------------------}}}
" Movement                                                                   {{{
"-------------------------------------------------------------------------------
" Split a line in two
map S i<cr><esc>

" Toggle Fold
map <leader>, za

" Open ctags definitions in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Use Tab and S-Tab as ; and ,
nnoremap <Tab> ;
nnoremap <S-Tab> ,

" Move up in down in visual mode even with capital J and K
vnoremap K k
vnoremap J j

"----------------------------------------------------------------------------}}}
" File and Project Management                                                {{{
"-------------------------------------------------------------------------------
nnoremap ''w :CtrlP /var/www/<cr>
nnoremap ''c :CtrlP /home/mephory/code/crescent/<cr>
nnoremap ''n :CtrlP /home/mephory/code/nexus/<cr>
nnoremap ''a :CtrlP /home/mephory/code/alexandria/<cr>
nnoremap ''v :e `=resolve(expand("~/.vimrc"))`<cr>
nnoremap ''' :cd %:p:h<cr>

"----------------------------------------------------------------------------}}}
" Format                                                                     {{{
"-------------------------------------------------------------------------------
" Tabularize
map <leader>a= :Tabularize /=<CR>
map <leader>a; :Tabularize /;<CR>
map <leader>a: :Tabularize /:\zs<CR>
map <leader>a, :Tabularize /,<CR>
map <leader>a\| :Tabularize /\|<CR>

" Headlines
nnoremap <leader>h yypVr-k
nnoremap <leader>H yypVr=k

" Retain selection after block indent
vnoremap < <gv
vnoremap > >gv

" Toggle hex view
nnoremap <leader>x :call ToggleHex()<cr>

" make K the opposite of J
nnoremap K kJ

" Start Table Mode
nnoremap <leader>tm :TableModeToggle<cr>

"----------------------------------------------------------------------------}}}
" Git                                                                        {{{
"-------------------------------------------------------------------------------
" Blame in visual mode (taken from https://github.com/r00k/dotfiles/blob/master/vimrc)
vmap <leader>gb :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
nmap <leader>gb :!git checkout ''<left>

nnoremap <leader>gs :!git st<cr>
nnoremap <leader>gc :!git commit -a -m ''<left>
nnoremap <leader>gC :!git commit<cr>
nnoremap <leader>gl :!git log<cr>
nnoremap <leader>gd :!git diff<cr>
nnoremap <leader>gD :!git diff 
nnoremap <leader>ga :!git add %<cr>
nnoremap <leader>gp :!git push<cr>
nnoremap <leader>gB :!git branch -a<cr>

"----------------------------------------------------------------------------}}}
" Other                                                                      {{{
"-------------------------------------------------------------------------------
" Insert ƒ when pressing C-f in insert mode
inoremap <c-F> <c-V>u0192

" Autocomplete with C-Tab (TODO doesn't work unfortunately, because xterm is not
" letting the keys through -- i still need to fix that)
inoremap <C-Tab> <C-p>

" Open the file openend by gf in a new tab
nnoremap gf <C-w>gF

" Y yanks until the end of line
nnoremap Y y$

" Open a quickfix window for the last search
"  ,/ searches only the current file
"  ,? recursively searched the current folder
nnoremap <leader>/ :call GrepCurrentFile()<cr>
nnoremap <leader>? :call GrepRecursive()<cr>
nnoremap <leader>;/ :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>
nnoremap <leader>;? :execute 'grep "'.@/.'" ./ -ir'<cr>:copen<cr>

" :W to save as root
command! W :w !sudo tee %

" Toggle taglist with <leader>t
nnoremap <leader>t :TlistToggle<cr>

" Paste to http://mephory.com/paste
vnoremap <leader>p :call PostSnippet()<cr>

" View diff of buffer against original file
nnoremap <leader>d :w !diff -u % -<cr>

" Improve command line navigation a bit
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Various mappings
set pastetoggle=<F8>
nnoremap <leader>n :set relativenumber!<cr>
command! Q q

" Use + and - for incrementing and decrementing a number
nnoremap <C-+> <C-a>
nnoremap <C--> <C-x>

vnoremap <leader>so :sort<cr>
nnoremap <leader>w :set list!<cr>
noremap <leader>c :TComment<cr>
nnoremap <C-x> :q<cr>
nmap <leader>q :QFAddNote 

" one rarely wants visual mode, so bind v to visual block mode instead
nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

" use ; as : to make colon commands easier to type
nnoremap  ;  :

" use . in visual mode to repeat command on every visually selected line
vnoremap . :norm.<cr>

" hilight words in different colors
hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
nnoremap <silent> <leader>0 :call clearmatches()<cr>
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

map ! :VimuxPromptCommand<cr>
map <leader>! :VimuxPromptCommand<cr>

" reload vimrc
nmap <leader>. :source ~/.vimrc<cr>

" swap ' and "
nnoremap ' "
nnoremap " '

" highlight column 80
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%81v', 100)

vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

nmap - :tabnew<cr>:e.<cr>

nmap <leader>r :Pandoc!<cr>
nmap <leader>R :Pandoc! pdf<cr>
nmap <ledaer>P :Pandoc! pdf<cr>

" let g:pandoc#command#autoexec_command='Pandoc! pdf'

"----------------------------------------------------------------------------}}}
" Include things                                                             {{{
"-------------------------------------------------------------------------------
" TODO: These need to be updated :(
nnoremap ,ijquery :0r !curl -s "http://code.jquery.com/jquery.min.js"<cr>
nnoremap ,ibootstrap :!wget "http://twitter.github.io/bootstrap/assets/bootstrap.zip" && unzip bootstrap.zip && rm bootstrap.zip<cr>
" }}}
" }}}
