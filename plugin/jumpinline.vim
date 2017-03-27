" jumpinline.vim
" --------------

" Options {{{
" (when editing the plugin, remember that these need to be unset when reloading)
if !exists('g:jumpinline_prefix')
    let g:jumpinline_prefix = '<space>'
endif
if !exists('g:jumpinline_use_submode')
    let g:jumpinline_use_submode = 1
endif
if !exists('g:jumpinline_leave_on_any_key')
    let g:jumpinline_leave_on_any_key = 1
endif
if !exists('g:jumpinline_bindings')
    let g:jumpinline_bindings = ['`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
endif
if !exists('g:jumpinline_dev_showcmd')
    let g:jumpinline_dev_showcmd = 0
endif
" }}}

function! jumpinline#GoPartLine(n, mode) " {{{
" = Function that jumps to n% of the current line
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
        if g:jumpinline_dev_showcmd == 1
            call jumpinline#Dev_ShowCmd(a:n, l:prefix, 0, 1)
        else
            execute l:prefix . '^'
            " ^ go to beginning of line (has to be done manually, as `0l` would
            "   go one character right of the line's beginning)
        endif
    else
        let l:product = round(l:lineln * a:n)
        let l:position = float2nr(l:product) - 1
        " ^ for example: [line length of 31] * 0.5 = 15.5 -> product
        "                round product to 16              -> position (to jump to)

        if g:jumpinline_dev_showcmd == 1
            call jumpinline#Dev_ShowCmd(a:n, l:prefix, l:position, 1)
        else
            execute l:prefix . '^' . l:position . 'l'
            " ^ in our example: go to beginning of line and move 16 places right
        endif
    endif
endfunction " }}}

function! jumpinline#Dev_ShowCmd(n, prefix, position, offset) " {{{
" = Function used in development to show on the line (offset) lines above the
" current line what command was typed (warning: that line will be replaced)
    let l:index = float2nr(a:n * 10) " e.g., 0.4 -> 4
    let l:letters = g:jumpinline_prefix . g:jumpinline_bindings[l:index]
    execute 'normal! ' . a:offset . 'k0c$Command: ' . l:letters
    if a:position == 0
        execute a:prefix . a:offset . 'j^'
    else
        execute a:prefix . a:offset . 'j^' . a:position . 'l'
    endif

endfunction " }}}


" Create submode {{{
if exists('g:submode_keep_leaving_key') && g:jumpinline_use_submode == 1
" Only create submode if submode plugin is installed and
" g:jumpinline_use_submode = 1 (default)
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

    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[0], ':call jumpinline#GoPartLine(0, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[1], ':call jumpinline#GoPartLine(0.1, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[2], ':call jumpinline#GoPartLine(0.2, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[3], ':call jumpinline#GoPartLine(0.3, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[4], ':call jumpinline#GoPartLine(0.4, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[5], ':call jumpinline#GoPartLine(0.5, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[6], ':call jumpinline#GoPartLine(0.6, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[7], ':call jumpinline#GoPartLine(0.7, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[8], ':call jumpinline#GoPartLine(0.8, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[9], ':call jumpinline#GoPartLine(0.9, "n")<CR>')
    call submode#map('jumpinline', 'n', '', g:jumpinline_prefix . g:jumpinline_bindings[10], ':call jumpinline#GoPartLine(1, "n")<CR>')
                                                                  
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[0], ':call jumpinline#GoPartLine(0, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[1], ':call jumpinline#GoPartLine(0.1, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[2], ':call jumpinline#GoPartLine(0.2, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[3], ':call jumpinline#GoPartLine(0.3, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[4], ':call jumpinline#GoPartLine(0.4, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[5], ':call jumpinline#GoPartLine(0.5, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[6], ':call jumpinline#GoPartLine(0.6, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[7], ':call jumpinline#GoPartLine(0.7, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[8], ':call jumpinline#GoPartLine(0.8, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[9], ':call jumpinline#GoPartLine(0.9, "v")<CR>')
    call submode#map('jumpinline', 'v', '', g:jumpinline_prefix . g:jumpinline_bindings[10], ':call jumpinline#GoPartLine(1, "v")<CR>')

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
    execute "nnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[10 . " :call jumpinline#GoPartLine(1, \"n\")<CR>"
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
    execute "vnoremap " . g:jumpinline_prefix . g:jumpinline_bindings[10 . " :call jumpinline#GoPartLine(1, \"v\")<CR>"
endif " }}}
