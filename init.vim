" It's VIM, not VI
set nocompatible

" Highlight syntax in programming languages.
filetype on
syntax on

" General indents.
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType json set sw=4
autocmd FileType json set ts=4
autocmd FileType rust set ts=2
autocmd FileType rust set sw=2
autocmd FileType python,c,cpp set autoindent
autocmd FileType c,cpp,python,cuda,json set expandtab
autocmd FileType make set noexpandtab
set smarttab

map<C-s> :w<CR>

" Uncomment if you want to match "/" searches in non-case-sensitive style.
" set ignorecase

set t_Co=256
set number
colorscheme minimalist
set cc=101
set ttimeoutlen=50

" FIXME(@were): This highlight is not working.
" Highlight trailing whitespace and lines longer than 80 columns.
highlight LongLine ctermbg=DarkYellow guibg=DarkYellow
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow

let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

call plug#begin('~/.vim/bundle/')
" For fuzzy file navigator
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }
" For git
Plug 'tpope/vim-fugitive'
" For color theme
Plug 'dikiaap/minimalist'
" For code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()            " required


filetype plugin on    " required

" Use tab to select next auto-completion.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Enter a placeholder session.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <Shift-K> to read the documents. At least it is useful for vimrc
" understanding.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" CoC code navigation keys.
map gd <Plug>(coc-definition)
map gi <Plug>(coc-implementation)
map gr <Plug>(coc-references)
map <F2> <Plug>(coc-rename)
map <F4>  <Plug>(coc-fix-current)
map [g <Plug>(coc-diagnostic-prev)
map ]g <Plug>(coc-diagnostic-next)

" Find files using Telescope command-line sugar.
" I actually like Ctrl+p to pop up the fuzzy finder, just like it is in
" VSCode.
map <C-p> :Telescope find_files<cr>
map fg <cmd>Telescope live_grep<cr>
map fb <cmd>Telescope buffers<cr>
map fh <cmd>Telescope help_tags<cr>

" LLVM coding guidelines conformance for VIM
" $Revision$
"
" Maintainer: The LLVM Team, http://llvm.org
" WARNING:    Read before you source in all these commands and macros!  Some
"             of them may change VIM behavior that you depend on.
"
" You can run VIM with these settings without changing your current setup with:
" $ vim -u /path/to/llvm/utils/vim/vimrc

" Optional
" C/C++ programming helpers
augroup csrc
  au!
  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp  set cindent
augroup END
" Set a few indentation parameters. See the VIM help for cinoptions-values for
" details.  These aren't absolute rules; they're just an approximation of
" common style in LLVM source.
set cinoptions=:0,g0,(0,Ws,l1

" Useful macros for cleaning up code to conform to LLVM coding guidelines

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g

