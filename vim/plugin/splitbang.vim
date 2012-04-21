if exists("did_splitbang")
	finish
endif
let g:did_splitbang = 1

fu! SplitBang(cmd)
	let output = system(a:cmd)
	if v:shell_error != 0 || strlen(a:text) > 1
		call Dmsg(output)
	end
endfu

fu! SBOnError(cmd)
	let output = system(a:cmd)
	if v:shell_error != 0
		call Dmsg(output)
	end
endfu

fu! Dmsg(text)
	10 new
	setl buftype=nofile bufhidden=delete noswapfile
	put =a:text
endfu
