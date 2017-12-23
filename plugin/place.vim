let g:place_single_character_mode = get(g:, 'place_single_character_mode', 1)
let g:place_blink = get(g:, 'place_blink', 1)

nnoremap <silent> <Plug>(place-insert) :<C-U>call place#insert(0)<cr>
nnoremap <silent> <Plug>(place-insert-multiple) :<C-U>call place#insert(1)<cr>
