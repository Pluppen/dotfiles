" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

highlight RedundantSpaces ctermbg=red guibg=red 
match RedundantSpaces /\s\+$/


" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

" Initialize plugin system
call plug#end()

nnoremap <C-Space> :NERDTreeToggle<CR>
