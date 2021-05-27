# NeoVim Floating Tag Preview

This plugin allows to easily preview tags in a floating window close to the
cursor. It aims to work as a mostly invisible extension to the native preview
functionality. In fact it tries to fill the gap of a still [missing
`previewwindowfunc` option](https://github.com/neovim/neovim/issues/12859). At
its core, it just opens a floating window before the native tag command gets
executed. Because the native commands search first for an already existing
preview window, they just pick up this window.

Additionally it provides some minor additions to improve the preview
functionality. Such include to automatically close the window on cursor
movement, open folds in the preview and apply highlight to the tag word. All
features are quite generic, so they can be disabled individually but also
can be also completely customized.

- [Installation](#installation)
- [Usage](#usage)
- [Customization](#customization)
- [Language Server Protocol Integration](#language-server-protocol-integration)

<p align="center">
  <img src="https://user-images.githubusercontent.com/12543647/119907993-dc0c9380-bf51-11eb-8c1c-ae7793803a9b.GIF" alt="Demo GIF" width="500px" />
</p>

---


## Installation

Use your favorite plugin manager to install the plugin or use it as [plain
package](https://neovim.io/doc/user/repeat.html#packages). The following
example uses [packer.nvim](https://github.com/wbthomason/packer.nvim) with some
lazy loading:

```vim
lua require('packer').use({
      \   'weilbith/nvim-floating-tag-preview',
      \   cmd = {'Ptag', 'Ptselect', 'Ptjump', 'Psearch', 'Pedit' },
      \ })
```


## Usage

Unfortunately is is not possible to overwrite native commands. As a
compromise, this plugin clones all tag preview related commands with an upper
case `P` version (e.g. `Ptag`, `Ptnext`, `Psearch`, ...). Native mappings
(e.g. `<C-W>}`) get automatically overwritten to use the floating versions
(can be disabled). Commands or mappings to focus (`<C-W>P`) or close
(`<C-W>z`) the preview window manually just work as always. When the cursor
moves, the window closes automatically again. While continue to preview
different tags (or just see the different locations), the same window gets
re-used and remains the same.

To preview a simple tag just execute `:Ptag <tag-name>` or type `<C-W>}` to
preview the word under the cursor. To cycle through the different definitions,
use `:Ptnext`, `Ptprevious` and friends. But also `:Psearch` might be an
interesting entrypoint.

You can run the plugin's health check to verify that NeoVim version supports
all necessary features (`:checkhealth floating_tag_preview`). Mind that this
does not work if you load the plugin in a lazy manner.


## Customization

Checkout [the
docs](https://github.com/weilbith/nvim-floating-tag-preview/blob/master/doc/floating_tag_preview.txt)
(`:help floating_tag_preview.txt`) to get further details on how to customize
each single part of the plugin.

## Language Server Protocol Integration

Tags might be an ancient or event obsolete feature of Vim/NeoVim. If you prefer
to use the data of a language server instead, consider to use
[nvim-lsp-smag](https://github.com/weilbith/nvim-lsp-smag). It makes LSP
locations like definitions, declaration, implementation etc. just work as tags.
Using both plugins in combination you can easily preview the definition of a
code object (e.g. a function or class) under the cursor. Cycling through the
previews will show you the definition, implementation etc. (depending on the
configuration). In fact, the demo GIF at the top is using this plugin in
background.

Thereby this is a minimal plugin which follows a traditional Vim/NeoVim
approach, but combine it with the most recent advanced features.
