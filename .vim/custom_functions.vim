" Merge a tab into a split in the previous window
function! MergeTabs()
    if tabpagenr() == 1
        return
    endif
    let bufferName = bufname("%")
    if tabpagenr("$") == tabpagenr()
        close!
    else
        close!
        tabprev
    endif
    vsplit
    execute "buffer " . bufferName
endfunction

function! UnmergeTabs()
    let bufferName = bufname("%")
    close!
    tabnew!
    execute "buffer " . bufferName
endfunction


" Grep the current file and open quickfix window
function! GrepCurrentFile()
    let grepquery = input("Search for: ")
    execute 'vimgrep /'.grepquery.'/g %'
    copen
endfunction

" Grep the whole directory recursively
function! GrepRecursive()
    let grepquery = input("Search for: ")
    execute 'grep "'.grepquery.'" ./ -ir'
    copen
endfunction

" Post a snipper to http://mephory.com/paste/
function! PostSnippet() range
    let tempFile = tempname()
    call writefile(getline(a:firstline, a:lastline), tempFile)

    let PS_Url = system('curl -s -F ss='.&syntax.' -F sc=@'.tempFile.' "http://mephory.com/paste/"')
    echo PS_Url
    let @+ = PS_Url
endfunction

" Toggle Hex Edit Mode
function! ToggleHexEdit()
    if (b:hexedit_mode == 'yes')
        :%!xxd -r
        let b:hexedit_mode = 'no'
    else
        :%!xxd
        let b:hexedit_mode = 'yes'
    endif
endfunction

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1

    " store cursor position
    let b:storedCursorPos = getpos('.')

    " switch to hex editor
    %!xxd

    " restore cursor position
    call cursor(b:storedCursorPos[1], b:storedCursorPos[2])
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0

    " store cursor position
    let b:storedCursorPos = getpos('.')

    " return to normal editing
    %!xxd -r

    " restore cursor position
    if exists('b:storedCursorPos') 
        call cursor(b:storedCursorPos[1], b:storedCursorPos[2]) 
    endif

  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

function! OpenURL(url)
    exe "silent !firefox \"".a:url."\""
    redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<q-args>)

" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " TODO: Toggle doesn't really work if, because the pattern being matched
    " isn't checked

    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    " let mid = 86750 + a:n
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    " silent! call matchdelete(mid)
    silent! let has_previous_match = matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    if has_previous_match == -1
        " Actually match the words.
        call matchadd("InterestingWord" . a:n, pat, 1, mid)
    endif

    " Move back to our original location.
    normal! `z
endfunction " }}}
