"The main entry point for our command"
"shouldPrompt = Whether or not we should prompt for multi character insertions
function! place#insert(shouldPrompt)
    let l:motion = place#get_motion()
    let l:insertion = place#get_insertion(a:shouldPrompt)
    let l:mapping = place#get_type_for_motion(l:motion[0])
    let l:old_a = @a

    normal! ma
    execute 'normal! ' . l:motion . l:mapping . l:insertion

    if g:place_blink ==# 1
        call place#blink()
    endif

    normal! `a

    let @a = l:old_a
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
        \'b': 'i',
        \'B': 'i',
        \'e': 'a',
        \'E': 'a',
        \'w': 'i',
        \'W': 'i',
        \'g': 'i',
        \'G': 'A',
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
    let l:two_char_motions = ['t', 'f', 'g']
    let l:motion = nr2char(getchar())

    if index(l:two_char_motions, l:motion) != -1
        let l:motion .= nr2char(getchar())
    else
        return l:motion
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

    if g:place_single_character_mode ==# 1
        return nr2char(getchar())
    endif

    return input('Insertion: ')
endfunction

function! place#blink()
    let l:blink = matchaddpos('DiffAdd', [[line('.'), col('.')]])
    redraw
    sleep 50m
    call matchdelete(l:blink)
    redraw
    sleep 50m
endfunction
