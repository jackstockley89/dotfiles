call plug#begin()
if executable('go')
	" VIM-GO PLUGIN
	Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
endif
call plug#end()
