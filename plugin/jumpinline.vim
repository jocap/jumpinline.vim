" jumpinline.vim
" --------------

" Options
if !exists('g:jumpinline_prefix')
    let g:jumpinline_prefix = '<space>'
endif

" Function that jumps to n% of the current line
function! jumpinline#GoPartLine(n, mode)
    let l:line = getline('.') " get line characters
    let l:line = substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '') " remove whitespace
    let l:lineln = strlen(l:line) " calculate length of line

    " - Decide how to execute the movement (normal/visual)
    let l:prefix = 'normal! ' " default
    if a:mode == 'n'
        let l:prefix = 'normal! '
    elseif a:mode == 'v'
        let l:prefix = 'normal! gv'
    endif

    if a:n == 0
        execute l:prefix . '^'
        " ^ go to beginning of line (has to be done manually, as `0l` would
        "   go one character right of the line's beginning)
    else
        let l:product = round(l:lineln * a:n)
        let l:position = float2nr(l:product)
        " ^ for example: [line length of 31] * 0.5 = 15.5 -> product
        "                round product to 16              -> position (to jump to)

        execute l:prefix . '^' . l:position . 'l'
        " ^ in our example: go to beginning of line and move 16 places right
    endif
endfunction

" Only create submode if submode plugin is installed
" (if not, this is optional, but highly useful)
if exists('g:submode_keep_leaving_key')

    " - Leave submode with any key
    let g:submode_keep_leaving_key = 1

    " - Enter submode with <space>n (default), where n*10 is the % of the
    "   current line you want to jump to.
    " - (for more information, see GoPartLine(n) function)
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '`', ':call jumpinline#GoPartLine(0, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '1', ':call jumpinline#GoPartLine(0.1, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '2', ':call jumpinline#GoPartLine(0.2, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '3', ':call jumpinline#GoPartLine(0.3, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '4', ':call jumpinline#GoPartLine(0.4, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '5', ':call jumpinline#GoPartLine(0.5, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '6', ':call jumpinline#GoPartLine(0.6, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '7', ':call jumpinline#GoPartLine(0.7, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '8', ':call jumpinline#GoPartLine(0.8, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '9', ':call jumpinline#GoPartLine(0.9, "n")<CR>')
    call submode#enter_with('linejump', 'n', '', g:jumpinline_prefix . '0', ':call jumpinline#GoPartLine(1, "n")<CR>')

    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '`', ':call jumpinline#GoPartLine(0, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '1', ':call jumpinline#GoPartLine(0.1, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '2', ':call jumpinline#GoPartLine(0.2, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '3', ':call jumpinline#GoPartLine(0.3, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '4', ':call jumpinline#GoPartLine(0.4, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '5', ':call jumpinline#GoPartLine(0.5, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '6', ':call jumpinline#GoPartLine(0.6, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '7', ':call jumpinline#GoPartLine(0.7, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '8', ':call jumpinline#GoPartLine(0.8, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '9', ':call jumpinline#GoPartLine(0.9, "v")<CR>')
    call submode#enter_with('linejump', 'v', '', g:jumpinline_prefix . '0', ':call jumpinline#GoPartLine(1, "v")<CR>')

    call submode#map('linejump', 'n', '', '`', ':call jumpinline#GoPartLine(0, "n")<CR>')
    call submode#map('linejump', 'n', '', '1', ':call jumpinline#GoPartLine(0.1, "n")<CR>')
    call submode#map('linejump', 'n', '', '2', ':call jumpinline#GoPartLine(0.2, "n")<CR>')
    call submode#map('linejump', 'n', '', '3', ':call jumpinline#GoPartLine(0.3, "n")<CR>')
    call submode#map('linejump', 'n', '', '4', ':call jumpinline#GoPartLine(0.4, "n")<CR>')
    call submode#map('linejump', 'n', '', '5', ':call jumpinline#GoPartLine(0.5, "n")<CR>')
    call submode#map('linejump', 'n', '', '6', ':call jumpinline#GoPartLine(0.6, "n")<CR>')
    call submode#map('linejump', 'n', '', '7', ':call jumpinline#GoPartLine(0.7, "n")<CR>')
    call submode#map('linejump', 'n', '', '8', ':call jumpinline#GoPartLine(0.8, "n")<CR>')
    call submode#map('linejump', 'n', '', '9', ':call jumpinline#GoPartLine(0.9, "n")<CR>')
    call submode#map('linejump', 'n', '', '0', ':call jumpinline#GoPartLine(1, "n")<CR>')

    call submode#map('linejump', 'v', '', '`', ':call jumpinline#GoPartLine(0, "v")<CR>')
    call submode#map('linejump', 'v', '', '1', ':call jumpinline#GoPartLine(0.1, "v")<CR>')
    call submode#map('linejump', 'v', '', '2', ':call jumpinline#GoPartLine(0.2, "v")<CR>')
    call submode#map('linejump', 'v', '', '3', ':call jumpinline#GoPartLine(0.3, "v")<CR>')
    call submode#map('linejump', 'v', '', '4', ':call jumpinline#GoPartLine(0.4, "v")<CR>')
    call submode#map('linejump', 'v', '', '5', ':call jumpinline#GoPartLine(0.5, "v")<CR>')
    call submode#map('linejump', 'v', '', '6', ':call jumpinline#GoPartLine(0.6, "v")<CR>')
    call submode#map('linejump', 'v', '', '7', ':call jumpinline#GoPartLine(0.7, "v")<CR>')
    call submode#map('linejump', 'v', '', '8', ':call jumpinline#GoPartLine(0.8, "v")<CR>')
    call submode#map('linejump', 'v', '', '9', ':call jumpinline#GoPartLine(0.9, "v")<CR>')
    call submode#map('linejump', 'v', '', '0', ':call jumpinline#GoPartLine(1, "v")<CR>')

else " non-submode mappings
    execute "nnoremap " . g:jumpinline_prefix . "` :call jumpinline#GoPartLine(0, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "1 :call jumpinline#GoPartLine(0.1, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "2 :call jumpinline#GoPartLine(0.2, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "3 :call jumpinline#GoPartLine(0.3, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "4 :call jumpinline#GoPartLine(0.4, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "5 :call jumpinline#GoPartLine(0.5, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "6 :call jumpinline#GoPartLine(0.6, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "7 :call jumpinline#GoPartLine(0.7, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "8 :call jumpinline#GoPartLine(0.8, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "9 :call jumpinline#GoPartLine(0.9, \"n\")<CR>"
    execute "nnoremap " . g:jumpinline_prefix . "0 :call jumpinline#GoPartLine(1, \"n\")<CR>"
                      " . 
    execute "vnoremap " . g:jumpinline_prefix . "` :call jumpinline#GoPartLine(0, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "1 :call jumpinline#GoPartLine(0.1, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "2 :call jumpinline#GoPartLine(0.2, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "3 :call jumpinline#GoPartLine(0.3, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "4 :call jumpinline#GoPartLine(0.4, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "5 :call jumpinline#GoPartLine(0.5, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "6 :call jumpinline#GoPartLine(0.6, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "7 :call jumpinline#GoPartLine(0.7, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "8 :call jumpinline#GoPartLine(0.8, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "9 :call jumpinline#GoPartLine(0.9, \"v\")<CR>"
    execute "vnoremap " . g:jumpinline_prefix . "0 :call jumpinline#GoPartLine(1, \"v\")<CR>"
endif
