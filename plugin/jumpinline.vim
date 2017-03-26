" - Function that jumps forward/back to n% of the current line {{{
function! GoPartLine(n, mode)
    let l:line = getline('.')
    let l:line = substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '') " remove whitespace
    let l:lineln = strlen(l:line)

    let l:prefix = 'normal! '
    if a:mode == 'n'
        let l:prefix = 'normal! '
    elseif a:mode == 'v'
        let l:prefix = 'normal! gv'
    endif

    if a:n == 0
        execute l:prefix . '^'
    else
        let l:quotient = round(l:lineln * a:n)
        let l:position = float2nr(l:quotient)
        execute l:prefix . '^' . l:position . 'l'
    endif
endfunction " }}}

" Only create submode if submode plugin is installed
if exists('g:submode_keep_leaving_key')

    " - Leave submode with any key
    let g:submode_keep_leaving_key = 1

    if !exists('g:jumpinline_prefix')
        let g:jumpinline_prefix = '<space>'
    endif

    " - Enter submode with <space>n, where n*10 is the % of the current line you
    "   want to jump to (for more information, see GoPartLine(n) function).
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

endif
