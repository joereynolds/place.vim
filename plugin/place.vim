let g:place_single_character_mode = get(g:, 'place_single_character_mode', 1)
nnoremap <silent> <Plug>(place-insert) :<C-U>call place#insert()<cr>
