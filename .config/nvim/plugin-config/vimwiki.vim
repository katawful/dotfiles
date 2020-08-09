let g:vimwiki_list = [{'path': '~/Documents/VimWikiHTML/VimWiki',
                      \ 'path_html': '~/Documents/VimWikiHTML'}]
let g:vimiwiki_folding = 'list'
let g:vimwiki_listsyms = '◯◔◐◕●✓'
nnoremap <leader>W<leader>W :VimwikiDiaryIndex<CR>
au VimLeave *.wiki :VimwikiAll2HTML
let g:vimwiki_global_ext = 0