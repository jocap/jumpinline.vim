# jumpinline.vim (v0.3)

*   [Description](#description)
    * [Examples](#examples) (gifs)
*   [Installation](#installation)
*   [Configuration](#configuration)
*   [Documentation](#documentation)
*   [Changelog](#changelog)

## Description

**jumpinline.vim** tries to fill a void in the Vim movement commands. There are
plenty of commands suitable for short movement along a line - like `h`, `l`,
`w` and `b` - and there are commands for searching for a specific character or
string on the line - like `t`, `f` and `/`.

But the small-movement commands become annoying to repeat when you have long
lines, and the searching commands become equally as annoying when you have a
line with a lot of repeated characters or words.

**jumpinline.vim** remedies this by adding a new movement
[submode](https://github.com/kana/vim-submode), designed for long movement
along a line. Enter the submode with `<space>` + one of the number keys and it
will jump to the corresponding percentage of the line.

For example: press `<space>3` and you will jump to the 30% of the line.

While the submode is still active, you can press several numbers to adjust your
position: `<space>45` will jump to 40% of the line, and then to 50%. This is
especially useful if you undershoot or overshoot your position.
 
The submode is exited after a short timeout, or immediately if you press any
key that isn't used by *jumpinline.vim*. This means that you can become as
precise as fast in your movements, by using the small-movement keys directly
after using the *jumpinline* submode to perform the big movement.

**Note:**

- *jumpinline.vim* currently only works in normal mode
- All keys can be configured (see [Configuration](#configuration))
- It can work with either "real" lines or graphical lines (see
  [Configuration](#configuration))
- The plugin requires [vim-submode](https://github.com/kana/vim-submode) to
  function properly (it can be used without it, but not very usefully)

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

Key used in combination with *g:jumpinline_bindings* to trigger the *jumpinline*
submode.

**g:jumpinline_bindings** (default: ``['`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0']``):

Keys used after *g:jumpinline_prefix* to jump to 0%, 10%, 20%, 30%, 40%, 50%,
60%, 70%, 80%, 90% and 100% of the line, respectively.

**g:jumpinline_graphical_line** (default: 0):

Whether or not to traverse the graphical line or the "real" line (which may
contain wraps).  If set to 1, *jumpinline.vim* will treat wraps as normal
line breaks. Very useful if you're working with text files without manual
wrapping.

**g:jumpinline_use_submode** (default: 1):

Whether or not to use [vim-submode](https://github.com/kana/vim-submode).
*Note:* it is highly recommended not to change this.

**g:jumpinline_capture_leaving_key** (default: 0):

If set to 1, it configures [vim-submode](https://github.com/kana/vim-submode)
to capture any unmapped key you type whilst in the *jumpinline* submode.  In
either case, typing an unmapped key (e.g., `x`) will quit the submode, but if
this option is set to 0, the typed key will be executed (e.g., `x` will be
executed and remove a character).

### Example configuration

If you want to press `<leader>` + the keys on the home row to enter the
*jumpinline* submode, enter this into your vim configuration:

    let g:jumpinline_prefix = '<leader>'
    let g:jumpinline_bindings = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', "'"]

## Documentation

To view the full documentation, see the help file:

    :help jumpinline.vim

## Changelog

    v0.1 ------------------------------------------------------------ 2017 March 27

    - Beta release, but in somewhat working condition.

    v0.2 ------------------------------------------------------------ 2017 March 28

    - Added *g:jumpinline_graphical_line* option.
    - Various bugfixes, in working condition.

    v0.3 ------------------------------------------------------------ 2017 March 31

    - Removed *g:jumpinline_leave_on_any_key* option
    - Added *g:jumpinline_capture_leaving_key* option
    - Added tests for default and custom configurations using vader.vim
