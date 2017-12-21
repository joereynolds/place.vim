"The main entry point for our command"
function! place#insert()
    let l:motion = place#get_motion()
    let l:insertion = place#get_insertion()
    let l:mapping = place#get_type_for_motion(l:motion)
    let l:old_a = @a

    normal! ma
    execute 'normal! ' . l:motion . l:mapping . l:insertion
    normal! `a

    let @a = l:old_a
endfunction

"We don't always want to use 'i' to enter insert mode.
"For example we would want ga$test to append test at
"the end of the line so we should probably use 'a'.
function! place#get_type_for_motion(char)
    let l:motion_mappings = {
        \'^': 'i',
        \'b': 'i',
        \'e': 'a',
        \'$': 'a',
        \'w': 'i',
        \'G': 'A',
    \}

    if index(keys(l:motion_mappings), a:char) == -1
        return
    endif

    return l:motion_mappings[a:char]
endfunction

"Gets the motion entered by the user after ga"
function! place#get_motion()
    "Obviously this only works with one character motions at the moment, change this.
    let l:motion = nr2char(getchar())
    return l:motion
endfunction

"Gets the text you wish to place after the motion
"i.e. gabtest
"It is the 'test' part of the above example
function! place#get_insertion()
    if g:place_single_character_mode ==# 1
        return nr2char(getchar())
    endif
    return input('Insertion: ')
endfunction
