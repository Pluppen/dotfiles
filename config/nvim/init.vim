" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

" Highlights trailing whitespaces with redbox
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

set tabstop=4
set shiftwidth=4
set expandtab
set nu

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'dracula/vim'
Plug 'digitaltoad/vim-pug'

" Initialize plugin system
call plug#end()

nnoremap <C-Space> :NERDTreeToggle<CR>

if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme dracula

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
