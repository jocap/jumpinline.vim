" jumpinline.vim
" --------------

" Don't waste time reload the plugin if it already is loaded {{{
if exists('g:jumpinline_already_loaded')
    if exists('g:jumpinline_dev_reload')
        if g:jumpinline_dev_reload != 1
            finish
        endif
    else
        finish
    endif
endif " }}}

" Options {{{
if !exists('g:jumpinline_prefix')
    let g:jumpinline_prefix = '<space>'
endif
if !exists('g:jumpinline_bindings')
    let g:jumpinline_bindings = ['`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
endif
if !exists('g:jumpinline_graphical_line')
    " use graphical line or real, perhaps wrapped line (default)
    let g:jumpinline_graphical_line = 0
endif
if !exists('g:jumpinline_use_submode')
    let g:jumpinline_use_submode = 1
endif
if !exists('g:jumpinline_leave_on_any_key')
    let g:jumpinline_leave_on_any_key = 1
endif
if !exists('g:jumpinline_dev_reload')
    " reload even if plugin already is loaded
    let g:jumpinline_dev_reload = 0
endif
" }}}

function! jumpinline#GoPartLine(...) " {{{
" = Function that jumps to n% of the current line
    " Arguments: (optional)
    let l:n =  a:0 >= 1 ? a:1 : 0 " a:0 = no of arguments, a:1 = 1st argument
    let l:mode = a:0 >= 2 ? a:2 : 'n'
    let l:justreturn = a:0 >= 3 ? a:3 : 0 " don't move, but return positions

    " Default: (normal mode)
    if g:jumpinline_graphical_line == 1
        let l:prefix = 'normal! g'
    else
        let l:prefix = 'normal! '
    endif
    if (l:mode == 'v') " visual mode
        if g:jumpinline_graphical_line == 1
            let l:prefix = 'normal! gvg'
        else
            let l:prefix = 'normal! gv'
        endif
    endif

    if g:jumpinline_graphical_line == 1
        let l:original_position = getpos('.')[2] " original cursor position
        execute 'normal! g^'
        " ^ go to graphical beginning of line
        let l:bol_position = getpos('.')[2] " beginning of (graphical) line position
        execute 'normal! g$'
        " ^ go to graphical end of line
        let l:eol_position = getpos('.')[2] " end of (graphical) line position

        let l:lineln = l:eol_position - l:bol_position " graphical line length
        let l:lineln = l:lineln + 1 " to account for the later subtraction by 1
    else
        let l:line = getline('.') " get line characters
        let l:totln = strlen(l:line)
        let l:line = substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '') " remove whitespace
        let l:lineln = strlen(l:line) " calculate length of line
        let l:spaceln = l:totln - l:lineln
    endif

    let l:product = round(l:lineln * l:n)
    let l:position = float2nr(l:product)
    " ^ for example: [line length of 31] * 0.5 = 15.5 -> product
    "                round product to 16              -> position (to jump to)

    if l:justreturn == 1
        if l:n == 0
            return l:spaceln + 1
        else
            return l:position + l:spaceln
        endif
    else
        if l:n == 0
            execute l:prefix . '^'
            " ^ go to beginning of line (has to be done manually, as `0l` would
            "   go one character right of the line's beginning)
        else
            execute l:prefix . '^' . (l:position - 1) . 'l'
            " ^ in our example: go to beginning of line and move 16 places right
        endif
    endif
endfunction " }}}

" TODO: create another branch for working on this
function! jumpinline#HighlightPositions(...)
    let l:mode =  a:0 >= 1 ? a:1 : 'n'

    " Save the current line's text and the cursor's position:
    let l:original_line = getline('.')
    let l:original_pos = getpos('.')[2]

    " Hide cursor
    let l:t_ve = &t_ve
    " let l:guicursor = &guicursor
    set t_ve=
    " set guicursor=n:block-NONE

    let l:columns = [0,0,0,0,0,0,0,0,0,0,0]
    let l:matches = [0,0,0,0,0,0,0,0,0,0,0]
    let i = 0
    for l:binding in g:jumpinline_bindings
        " 1) Retrieve all the positions -> l:columns
        let j = i * 0.1
        let l:columns[i] = jumpinline#GoPartLine(j, l:mode, 1)

        " 2) Replace characters on the columns with corresponding number
        "    and add match for highlighting
        let l:lineno = getpos('.')[1]
        call cursor(l:lineno, l:columns[i])
        execute 'hi jumpinline_' . i . ' ctermfg=195 ctermbg=124'
        execute 'normal! r' . g:jumpinline_bindings[i]
        let l:matches[i] = matchadd('jumpinline_' . i, '\%' . l:lineno . 'l\%' . l:columns[i] . 'v' . g:jumpinline_bindings[i])
        let i += 1
    endfor

    " Restore cursor
    "set t_ve=l:t_ve
    " set guicursor=l:guicursor

endfunction

" Create submode {{{
if g:jumpinline_use_submode == 1
" (submode is optional, but highly useful)

    " - Leave submode with any key
    let g:submode_keep_leaving_key = g:jumpinline_leave_on_any_key

    " - Enter submode with <space>n (default), where n*10 is the % of the
    "   current line you want to jump to.
    " - (for more information, see GoPartLine(n) function)
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[0], ':call jumpinline#GoPartLine(0, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[1], ':call jumpinline#GoPartLine(0.1, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[2], ':call jumpinline#GoPartLine(0.2, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[3], ':call jumpinline#GoPartLine(0.3, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[4], ':call jumpinline#GoPartLine(0.4, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[5], ':call jumpinline#GoPartLine(0.5, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[6], ':call jumpinline#GoPartLine(0.6, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[7], ':call jumpinline#GoPartLine(0.7, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[8], ':call jumpinline#GoPartLine(0.8, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[9], ':call jumpinline#GoPartLine(0.9, "n")<CR>')
    call submode#enter_with('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[10], ':call jumpinline#GoPartLine(1, "n")<CR>')

    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[0], ':call jumpinline#GoPartLine(0, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[1], ':call jumpinline#GoPartLine(0.1, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[2], ':call jumpinline#GoPartLine(0.2, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[3], ':call jumpinline#GoPartLine(0.3, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[4], ':call jumpinline#GoPartLine(0.4, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[5], ':call jumpinline#GoPartLine(0.5, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[6], ':call jumpinline#GoPartLine(0.6, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[7], ':call jumpinline#GoPartLine(0.7, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[8], ':call jumpinline#GoPartLine(0.8, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[9], ':call jumpinline#GoPartLine(0.9, "v")<CR>')
    call submode#enter_with('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[10], ':call jumpinline#GoPartLine(1, "v")<CR>')

    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[0], ':call jumpinline#GoPartLine(0, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[1], ':call jumpinline#GoPartLine(0.1, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[2], ':call jumpinline#GoPartLine(0.2, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[3], ':call jumpinline#GoPartLine(0.3, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[4], ':call jumpinline#GoPartLine(0.4, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[5], ':call jumpinline#GoPartLine(0.5, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[6], ':call jumpinline#GoPartLine(0.6, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[7], ':call jumpinline#GoPartLine(0.7, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[8], ':call jumpinline#GoPartLine(0.8, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[9], ':call jumpinline#GoPartLine(0.9, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_bindings[10], ':call jumpinline#GoPartLine(1, "n")<CR>')
                                            
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[0], ':call jumpinline#GoPartLine(0, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[1], ':call jumpinline#GoPartLine(0.1, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[2], ':call jumpinline#GoPartLine(0.2, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[3], ':call jumpinline#GoPartLine(0.3, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[4], ':call jumpinline#GoPartLine(0.4, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[5], ':call jumpinline#GoPartLine(0.5, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[6], ':call jumpinline#GoPartLine(0.6, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[7], ':call jumpinline#GoPartLine(0.7, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[8], ':call jumpinline#GoPartLine(0.8, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[9], ':call jumpinline#GoPartLine(0.9, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_bindings[10], ':call jumpinline#GoPartLine(1, "v")<CR>')

" }}}
else " => non-submode mappings (not really too useful) {{{
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[0] . " :call jumpinline#GoPartLine(0, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[1] . " :call jumpinline#GoPartLine(0.1, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[2] . " :call jumpinline#GoPartLine(0.2, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[3] . " :call jumpinline#GoPartLine(0.3, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[4] . " :call jumpinline#GoPartLine(0.4, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[5] . " :call jumpinline#GoPartLine(0.5, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[6] . " :call jumpinline#GoPartLine(0.6, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[7] . " :call jumpinline#GoPartLine(0.7, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[8] . " :call jumpinline#GoPartLine(0.8, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[9] . " :call jumpinline#GoPartLine(0.9, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[10] . " :call jumpinline#GoPartLine(1, \"n\")<CR>"
                      " . 
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[0] . " :call jumpinline#GoPartLine(0, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[1] . " :call jumpinline#GoPartLine(0.1, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[2] . " :call jumpinline#GoPartLine(0.2, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[3] . " :call jumpinline#GoPartLine(0.3, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[4] . " :call jumpinline#GoPartLine(0.4, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[5] . " :call jumpinline#GoPartLine(0.5, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[6] . " :call jumpinline#GoPartLine(0.6, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[7] . " :call jumpinline#GoPartLine(0.7, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[8] . " :call jumpinline#GoPartLine(0.8, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[9] . " :call jumpinline#GoPartLine(0.9, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[10] . " :call jumpinline#GoPartLine(1, \"v\")<CR>"
endif " }}}

let g:jumpinline_already_loaded = 1
