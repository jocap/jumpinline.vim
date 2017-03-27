# jumpinline.vim

*   [Description](#description)
    * [Examples](#examples) (gifs)
*   [Installation](#installation)
*   [Configuration](#configuration)
*   [Documentation](#documentation)

## Description

*jumpinline.vim* is a plugin that allows the user to quickly find
the right place in a line, by simply using the number keys on the keyboard.

To jump to 10% of the current line, press `<space>1`. For 50%, press `<space>5`.
If you jump a little bit too far, you can adjust by pressing any other number,
as many times as you like, without having to press space again.

This works because *jumpinline.vim* runs as its own
[submode](https://github.com/kana/vim-submode), which exits back to
normal/visual mode after a short timeout - or automatically, if you press any
other letter that isn't used by *jumpinline.vim*.

This means that it is very easy to jump quickly to any position in the current
line, without having to think about what character to jump to using `t`/`f`, or
having to press `w` a bunch of times until you find your place.

*jumpinline.vim* is especially useful when working with lines containing a lot
of repetition, making `t`, `f` and even `/` a pain to use. Instead, just
estimate how far you need to go into the line and press the corresponding
number. Need to go the middle of the file, approximately? Just press `<space>5`
and adjust using `hjkl` or another number.

**Note:**

- *jumpinline.vim* works in normal, visual and select mode
- All keys can be configured
- The plugin requires [vim-submode](https://github.com/kana/vim-submode) to function
  properly (it can be used without it, but it wouldn't be very useful)

### Examples

Below are embedded three gifs of *jumpinline.vim* in action, showing a version
of the plugin with debugging tools enabled to display what command is being
executed.  In your version, this won't be visible.

![Example: LaTeX code editing](https://github.com/jocap/jumpinline.vim/blob/master/img/example-latex-code.gif?raw=true)
![Example: VimL editing](https://github.com/jocap/jumpinline.vim/blob/master/img/example-viml.gif?raw=true)
![Example: LaTeX text editing](https://github.com/jocap/jumpinline.vim/blob/master/img/example-latex-text.gif?raw=true)

## Installation

#### vim-plug

Paste the following into your vim configuration:

    Plug 'kana/vim-submode' | Plug 'jocap/jumpinline.vim'

[vim-submode](https://github.com/kana/vim-submode) is a dependency.  If you
already have it installed, only paste the second part:

    Plug 'jocap/jumpinline.vim' " requires kana/vim-submode

To install, reload vim and run `:PlugInstall`.

#### Vundle

Paste the following into your vim configuration:

    Plugin 'kana/vim-submode'
    Plugin 'jocap/jumpinline.vim' " requires kana/vim-submode

To install, reload vim and run `:PluginInstall`.

#### Pathogen

First, install [vim-submode](https://github.com/kana/vim-submode): (skip this
step if you already have it installed)

    ~/.vim/bundle $ git submodule add git@github.com:kana/vim-submode.git

Then, install *jumpinline.vim*:

    ~/.vim/bundle $ git submodule add git@github.com:jocap/jumpinline.vim.git

**Note:** if you aren't using Pathogen with submodules, run `git clone` instead
of `git submodule add`.

## Configuration

*jumpinline.vim* is configuration-friendly. The following variables can be
configured:

**g:jumpinline_prefix** (default: `'<space>'`):

Key used in combination with *g:jumpinline_mappings* to trigger the *jumpinline*
submode.

**g:jumpinline_bindings** (default: ``['`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0']``):

Keys used after *g:jumpinline_prefix* to jump to 0%, 10%, 20%, 30%, 40%, 50%,
60%, 70%, 80%, 90% and 100% of the line, respectively.

**g:jumpinline_use_submode** (default: 1):

Whether or not to use [vim-submode](https://github.com/kana/vim-submode).
*Note:* it is highly recommended not to change this.

**g:jumpinline_leave_on_any_key** (default: 1):

Alias for *g:submode_keep_leaving_key*, a [vim-submode](https://github.com/kana/vim-submode) option.  Lets the user exit the submode by pressing any key that isn't mapped to the submode. *Note*: it is recommended not to change this.

### Example configuration

If you want to press `a` + the keys from Q through [ instead of the default `<space>` + \`-0, enter this into your vim configuration:

    let g:jumpinline_prefix = 'a'
    let g:jumpinline_bindings = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[']

Of course, this particular setup is not recommended, but serves as a simple
example.

## Documentation

To view the full documentation, see the help file:

    :help jumpinline.vim
