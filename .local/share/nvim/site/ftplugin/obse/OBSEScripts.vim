function! OBSECompile()
	let l:filename = expand("%:p")
	let l:filename = substitute(l:filename, " ", '\\ ', "")
	below 3split term:///usr/bin/zsh -c /home/kat/.local/share/nvim/scripts/cse-script.sh
	call jobsend(b:terminal_job_id, l:filename)
	call jobsend(b:terminal_job_id, ' ')
	startinsert
endfunction

nnoremap <leader>W :call OBSECompile()<CR>
