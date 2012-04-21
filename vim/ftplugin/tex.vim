if exists("did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

nnoremap <buffer><silent> tb :call SBOnError("pdflatex -interaction nonstopmode ".shellescape(expand("%")))<CR>
nnoremap <buffer><silent> tv :call SBOnError("xdg-open ".shellescape(expand("%:p:r")).".pdf &> /dev/null")<CR>
