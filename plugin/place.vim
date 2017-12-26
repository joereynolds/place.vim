let g:place_blink = get(g:, 'place_blink', 1)

nnoremap <silent> <Plug>(place-insert) :<C-U>call place#insert(0,0)<cr>
nnoremap <silent> <Plug>(place-insert-multiple) :<C-U>call place#insert(1,0)<cr>
nnoremap <silent> <Plug>(place-insert-repeat) :<C-U>call place#insert(0,1)<cr>
