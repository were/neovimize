" It's VIM, not VI
set nocompatible

" Highlight syntax in programming languages.
filetype on
syntax on

" General indents.
autocmd FileType python,vim,sh set sw=4
autocmd FileType python,vim,sh set ts=4
autocmd FileType json set sw=4
autocmd FileType json set ts=4
autocmd FileType c,cpp,rust,cmake set ts=2
autocmd FileType c,cpp,rust,cmake set sw=2
autocmd FileType c,cpp set autoindent
autocmd FileType c,cpp,python,cuda,json,vim,sh,cmake set expandtab
autocmd FileType make set noexpandtab
set smarttab

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

map<C-s> :w<CR>

" Uncomment if you want to match "/" searches in non-case-sensitive style.
" set ignorecase

set t_Co=256
set number
set cc=101
set ttimeoutlen=50

" FIXME(@were): This highlight is not working.
" Highlight trailing whitespace and lines longer than 80 columns.
highlight LongLine ctermbg=DarkYellow guibg=DarkYellow
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Use tab to select next auto-completion.
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" CoC code navigation keys.
nnoremap gd <Plug>(coc-definition)
nnoremap gi <Plug>(coc-implementation)
nnoremap gr <Plug>(coc-references)
nnoremap <F2> <Plug>(coc-rename)
nnoremap <F4>  <Plug>(coc-fix-current)
nnoremap [g <Plug>(coc-diagnostic-prev)
nnoremap ]g <Plug>(coc-diagnostic-next)

" Find files using Telescope command-line sugar.
" I actually like Ctrl+p to pop up the fuzzy finder, just like it is in
" VSCode.
if system('git rev-parse --is-inside-work-tree') == "true\n"
  nnoremap <C-p> :lua require'telescope.builtin'.git_files{recurse_submodules=true}<cr>
else
  nnoremap <C-p> :lua require'telescope.builtin'.find_files{no_ignore=true,no_ignore_parent=true}<cr>
endif
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>

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

