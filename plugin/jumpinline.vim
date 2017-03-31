" jumpinline.vim
" --------------

" Don't waste time reload the plugin if it already is loaded: {{{
if exists('g:jumpinline_already_loaded')
    if exists('g:jumpinline_dev_reload')
        if g:jumpinline_dev_reload != 1
            finish
        endif
    else
        if g:jumpinline_already_loaded == 1
            finish
        endif
    endif
endif " }}}

" Function that jumps to n% of the current line {{{
function! jumpinline#GoPartLine(n, mode)
    let l:line = getline('.') " get line characters

    " - Calculate line length {{{
    if g:jumpinline_graphical_line == 1
        " - Decide how to execute the movement (normal/visual)
        if a:mode == 'v'
            let l:prefix = 'normal! gvg'
        else
            let l:prefix = 'normal! g'
        endif

        let l:original_position = col('.') " original cursor position
        execute l:prefix . '^'
        " ^ go to graphical beginning of line
        let l:bol_position = col('.') " beginning of (graphical) line position
        execute l:prefix '$'
        " ^ go to graphical end of line
        let l:eol_position = col('.') " end of (graphical) line position

        let l:lineln = l:eol_position - l:bol_position " graphical line length
        let l:lineln = l:lineln + 1 " to account for the later subtraction by 1
    else
        let l:line = substitute(l:line, '^\s*', '', '') " remove indent
        let l:lineln = strlen(l:line) " calculate length of line
    endif
    " }}}

    let l:indent = indent(line('.'))

    let l:product = round(l:lineln * a:n)
    let l:position = float2nr(l:product)
    let l:position = l:position + l:indent

    if a:n == 0
        let l:position = l:position + 1
    endif

    call cursor(line('.'), l:position)
endfunction " }}}

" Function that loads plugin {{{
function! jumpinline#Load()

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
    if !exists('g:jumpinline_capture_leaving_key')
        let g:jumpinline_capture_leaving_key = 0
    endif
    if !exists('g:jumpinline_dev_reload')
        " reload even if plugin already is loaded
        let g:jumpinline_dev_reload = 0
    endif
    " }}}

    " Create submode {{{
    if g:jumpinline_use_submode == 1
    " (submode is optional, but highly useful)

        if g:jumpinline_capture_leaving_key == 0
            let g:submode_keep_leaving_key = 1
        endif

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
endfunction
" }}}

" Automatically load plugin, unless otherwise told:
if exists('g:jumpinline_dev_noload')
    if g:jumpinline_dev_noload != 1
        call jumpinline#Load()
    endif
else
    call jumpinline#Load()
endif
