inoremap <silent><expr> <C-Space> pumvisible() ? "\<C-n>" : 
	\ <SID>check_back_space() ? "\<Tab>" :
	\ coc#refresh()
inoremap <silent><expr> <A-Space> pumvisible() ? "\<C-p>" : "\<S-Tab>" 
"inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" enable for file types
autocmd FileType text,wiki,tex let b:coc_suggest_disable = 1