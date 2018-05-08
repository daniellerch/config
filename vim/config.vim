
" 80C Line
highlight ColorColumn ctermbg=4
set colorcolumn=81,121



" Edition
set nosmartindent
set tabstop=3
set shiftwidth=3
set expandtab
set hlsearch
set fdm=marker
syntax on

" big copy & paste
set viminfo='100,<1000,s100,h

" Use this ctags file
set tags=~/.vim/ctags

" Bar color
hi StatusLine ctermbg=white ctermfg=darkblue
hi StatusLineNC ctermbg=white ctermfg=black


autocmd BufNewFile,BufRead *.py set tabstop=4
autocmd BufNewFile,BufRead *.py set shiftwidth=4
" autocmd BufNewFile,BufRead *.py set foldmethod=indent
" autocmd BufNewFile,BufRead *.py set foldnestmax=2

autocmd BufNewFile,BufRead *.vue set filetype:html
autocmd BufNewFile,BufRead *.vue set tabstop=2
autocmd BufNewFile,BufRead *.vue set shiftwidth=2



" CTAGS {{{

fu! CTags_PHP_generate()
   let cmd="!ctags-exuberant -f ~/.vim/ctags "
   let cmd.="-h \".php\" -R  "
   let cmd.="--exclude=\"\.svn\" "
   let cmd.="--totals=yes "
   let cmd.="--tag-relative=yes "
   let cmd.="--PHP-kinds=+cf "
   let cmd.="--regex-PHP='/abstract class ([^ ]*)//c/' "
   let cmd.="--regex-PHP='/interface ([^ ]*)//c/' "
   let cmd.="--regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)//f/'"
   execute cmd
endfunction


fu! CTags_tag()
   let w=expand("<cword>")
   belowright split 
   resize 15
   execute 'tag '.w
endfunction

fu! CTags_tselect()
   let w=expand("<cword>")
   belowright split 
   resize 15
   execute 'tselect '.w
endfunction


" }}}

" SYNTAX FUNCTIONS {{{

fu! Syntax_PHP_check()
   !php5 -l %
endfunction

fu! Syntax_HTML()
   filetype indent on
   set filetype=html
endfunction

fu! Syntax_JS()
   filetype indent on
   set filetype=javascript
endfunction

fu! Syntax_PHP()
   filetype indent on
   set filetype=php
endfunction

" }}}

" FORMAT FUNCTIONS {{{
function Format_CamelToSnake()
:%s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g
endfunction

function FormatPHP_OpenKeyInNewLine()
:%s/^\(\s*\)\(switch\|if\|for\|foreach\|while\)\s*(\(.*\))\s*{/\1\2(\3)\r\1{/gc
endfunction

function FormatPHP_CleanCarriageReturn()
:%s /\r//gc
endfunction

function FormatPHP_InsertVimMarks()

   let l=-1
   while line('.')>l

      set nofoldenable

      let l=line('.')

      " Find function beginning
      execute './\(\s*\)\(protected\|private\|public\|\)\(\s*\)function\([^(]*\)'

      " Get string (spaces) before declaration
      let pref = matchstr(getline('.'), '\s*')

      " Put beginning mark
      execute 's//\1\/\/ {{{\4()\r\1\2\3function\4/gc'

      " Find end function
      execute './^'.pref.'}'

      " Put end mark
      execute 's//'.pref.'}\r'.pref.'\/\/ }}}/gc'

      set fdm=marker
   endwhile

endfunction

" }}}

" SCRIPT EXECUTION {{{

function Script_FindFunction()
let cmd="!~/working/scripts/edition/vim_find_function.sh " . expand("<cword>")
   execute cmd
endfunction

function Script_FindString()
let cmd="!~/working/scripts/edition/vim_find_string.sh " . expand("<cword>")
   execute cmd
endfunction

" }}}


"autocmd BufNewFile,BufRead *.py set tabstop=4
"autocmd BufNewFile,BufRead *.py set shiftwidth=4
"autocmd BufNewFile,BufRead *.py set smartindent
"autocmd BufNewFile,BufRead *.py set textwidth=79


:noremap ff :call Script_FindFunction()<cr>
:noremap fs :call Script_FindString()<cr>
":noremap j :call CTags_tag()<cr>
:noremap j <C-]>
:noremap b <C-T>
":noremap s :call CTags_tselect()<cr>
":noremap S :execute('tselect '.expand('<cword>')) <cr>



