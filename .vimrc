"Commands
:se nu
:syntax on
:set tabstop=4
:set autoindent

"Startup plugins
autocmd VimEnter * NERDTree

"Quit nerdtree if last in buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
