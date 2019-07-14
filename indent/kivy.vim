" Vim indent file
" Language:             Kivy
" Previous Maintainer:  Allan Chain <txsmlf@gmail.com>
" Latest Revision:      2019-7-14

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetKivyIndent()
setlocal indentkeys=!^F,o,O
setlocal nosmartindent

if exists("*GetKivyIndent")
  finish
endif

function GetKivyIndent()
  let lnum = prevnonblank(v:lnum - 1)

  if lnum == 0
    return 0
  endif

  let ind = indent(lnum)

  if getline(lnum) =~? '^.*:$'
    let ind = ind + shiftwidth()
  endif

  return ind
endfunction
