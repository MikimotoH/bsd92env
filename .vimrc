set enc=utf-8
set fileencoding=utf-8
let $PAGER=''

set nocompatible               " be iMproved

filetype plugin indent on     " required!

execute pathogen#infect()
syntax on
filetype plugin indent on
nnoremap <F7> :NERDTreeToggle<CR> 
nnoremap <F8> :TagbarToggle<CR>

set tabstop=8 expandtab shiftwidth=4 softtabstop=4
set cindent 
set cino=g0
"set exrc " external .vimrc for each project folder
set backspace=2  " allow backspacing over everything in insert mode
set autoread
set ruler        " always show cursor position
set hlsearch incsearch ignorecase title ttyfast ls=2 showcmd showmatch
" TIP 137 Automatically wrap left and right for cursor to previous/next line
set whichwrap+=<,>,h,l,[,]
" TIP 769 Highlight current line
set cursorline
hi CursorLine   cterm=underline ctermbg=darkgray ctermfg=white guibg=darkred guifg=white
"set number


set statusline=%f\ %{tagbar#currenttag('%s','','f')}%<%=POS=[%l,%v]%p%%
set laststatus=2
set title titlestring=%-.355{tagbar#currenttag('%s','','fs')}%<

" VIM Tip 1638
" CScope
if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif


"-----------
" Tip 1518 Improved hex editing
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" Alt-L to reload tags
" map <C-[>l 
nnoremap <C-L> :!exctags -R --c-kinds=+p --links=no --sort=foldcase . <CR>
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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
    " switch to hex editor
    %!xxd -g 1
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
"
" Automatically handle hex mode
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd -g 1
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd -g 1
  au BufWritePost *.bin set nomod | endif
augroup END


" Omni Completion in Vim | Software ahoy!
" http://aufather.wordpress.com/2010/08/26/omni-completion-in-vim/
if v:version >= 700
  set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
  let OmniCpp_GlobalScopeSearch   = 1
  let OmniCpp_DisplayMode         = 1
  let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
  let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
  let OmniCpp_ShowAccess          = 1 "show access in pop-up
  let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
  set completeopt=menuone,menu,longest,preview
  let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
endif
set omnifunc=ccomplete#Complete
set complete=.,b,u,]
set wildmode=longest,list:longest
set wildmode=longest,list,full
set wildmenu

set tags+=/usr/src/sys/amd64/include/tags,/usr/src/sys/x86/include/tags,/usr/src/sys/tags,/usr/include/tags,/usr/include/sys/tags,./tags,tags;

" Tip 1235
" Use embedded Python Calculator
command! -nargs=+ Calc :py print <args>
:py from math import *


colorscheme wombat256
hi CursorLine cterm=bold ctermbg=Black
set diffopt+=iwhite

" renamec.vim 
noremap <Leader>r :call Renamec()<cr>
" For Local replace name
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>
" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" preview window
nnoremap <leader>v : exe "ptag! " .  expand("<cword>")<CR>
" Alt-] ; You have to set iTerm alt(option)⌥  to send ESC+
nnoremap <C-[>] : exe "tag! " . expand("<cword>")<CR>


" Clang_complete
let g:clang_library_path = "/usr/local/lib"
let g:clang_complete_auto=1
let g:clang_user_options="-std=gnu11"
let g:clang_use_library=1


set runtimepath^=~/.vim/bundle/ctrlp.vim

" autocomplpop
let g:AutoComplPop_Behavior = { 
            \ 'c': [ {'command' : "\<C-x>\<C-o>",
            \       'pattern' : ".",
            \       'repeat' : 0}
            \      ]  
            \}
let g:AutoComplPop_CompleteoptPreview = 1

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0

" Use Ag the_silver_searcher instead of ack
let g:ackprg = 'ag --nogroup --nocolor --column'

