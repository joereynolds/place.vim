"The main entry point for our command"
"shouldPrompt = Whether or not we should prompt for multi character insertions
"shouldRepeat = Whether or not to reuse values for dot repeat
function! place#insert(shouldPrompt, shouldRepeat)
    if !a:shouldRepeat
        let s:motion = place#get_motion()
        let s:insertion = place#get_insertion(a:shouldPrompt)
        let s:mapping = place#get_type_for_motion(s:motion[0])
    endif

    "This is a hack to keep the cursor position for undos
    "see here http://vim.wikia.com/wiki/Restore_the_cursor_position_after_undoing_text_change_made_by_a_script
    normal! ix
    normal! "_x

    let pos = winsaveview()
    execute 'normal! ' . s:motion . s:mapping . s:insertion

    if g:place_blink == 1
        call place#blink()
    endif

    call winrestview(pos)

    silent! call repeat#set("\<Plug>(place-insert-repeat)", v:count)
endfunction

"We don't always want to use 'i' to enter insert mode.
"For example we would want ga$test to append test at
"the end of the line so we should probably use 'a'.
function! place#get_type_for_motion(char)
    let l:motion_mappings = {
        \'^': 'i',
        \'$': 'a',
        \'f': 'a',
        \'t': 'a',
        \'F': 'i',
        \'T': 'i',
        \'b': 'i',
        \'B': 'i',
        \'e': 'a',
        \'E': 'a',
        \'w': 'i',
        \'W': 'i',
        \'g': 'i',
        \'G': 'A',
        \'}': 'i',
        \'{': 'i'
    \}

    if index(keys(l:motion_mappings), a:char) == -1
        return
    endif

    return l:motion_mappings[a:char]
endfunction

"Gets the motion entered by the user after ga
function! place#get_motion()
    "Some motions either take an argument or are two characters long. Prompt
    "twice for these
    let l:two_char_motions = ['t', 'f', 'F', 'T', 'g']
    let l:motion = nr2char(getchar())

    if index(l:two_char_motions, l:motion) != -1
        let l:motion .= nr2char(getchar())
    endif

    return l:motion
endfunction

"Gets the text you wish to place after the motion
"i.e. gabtest
"It is the 'test' part of the above example
"shouldPrompt = Whether or not we should prompt for multi character insertions
function! place#get_insertion(shouldPrompt)
    if a:shouldPrompt ==# 1
        return input('Insertion: ')
    endif

    return nr2char(getchar())
endfunction

function! place#blink()
    let l:blink = matchaddpos('DiffAdd', [[line('.'), col('.')]])
    redraw
    sleep 50m
    call matchdelete(l:blink)
    redraw
    sleep 50m
endfunction
