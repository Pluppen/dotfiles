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
Plug 'frazrepo/vim-rainbow'
Plug 'itchyny/lightline.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Initialize plugin system
call plug#end()

nnoremap <C-Space> :NERDTreeToggle<CR>

if (has("termguicolors"))
    set termguicolors
endif

syntax enable
colorscheme dracula

let g:rainbow_active = 1

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12

" Vanilla fuzzy search
set path+=**
set wildmenu

" Templating
nnoremap ,html :-1read $HOME/dotfiles/templates/.skeleton.html<CR>3jwf>a
nnoremap ,react :-1read $HOME/dotfiles/templates/.react-component-template.js<CR>ggvG:s/ComponentName/
