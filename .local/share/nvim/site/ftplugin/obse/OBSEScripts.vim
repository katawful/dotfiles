function! OBSECompile()
	let filename = expand('%:p')
	below 3split term:///usr/bin/zsh -c /home/kat/.local/share/nvim/scripts/cse-script.sh
	call jobsend(b:terminal_job_id, filename)
	call jobsend(b:terminal_job_id, ' ')
	startinsert
endfunction

nnoremap <leader>W :call OBSECompile()<CR>
