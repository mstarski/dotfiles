"Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot' "Syntax highlighting
Plug 'dense-analysis/ale' "Linter
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Intellisense engine
Plug 'vim-airline/vim-airline' "This bar at the bottom
Plug 'joshdick/onedark.vim' "One dark theme
Plug 'https://github.com/rafaqz/ranger.vim' "Modifications for ranger
Plug 'https://github.com/alvan/vim-closetag' "Close html tags 
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } "Markdown preview
Plug 'mattn/emmet-vim' "html emmet
Plug 'haya14busa/incsearch.vim' "incremental search
Plug 'christoomey/vim-tmux-navigator' "integration with tmux
Plug 'zivyangll/git-blame.vim' "Git blame
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

"Config
syntax on
let g:javascript_plugin_jsdoc = 1 "Enables syntax highlighting for JSDocs
let g:ale_sign_error = '❌' "Linter signs for error and warnings 
let g:ale_sign_warning = '⚠️'
"colorscheme onedark "Load onedark scheme

colorscheme gruvbox "Load gruvbox theme
set background=light

set relativenumber "Sets relative line numbers
"Ale config
let g:ale_linters = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'typescript': ['prettier', 'eslint'],
  \ 'ruby': ['solargraph']
  \ }
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ranger_map_keys = 0
set tabstop=3 " Set how much space on screen tab takes (only visually)
set shiftwidth=3
set shell=/bin/zsh "Set default shell for vim
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ } 
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:user_emmet_leader_key=',' "trigger emmet on double ,, click

" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"Keymap
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap) 

" Braces completion
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

nmap - :RangerEdit<CR>
nmap <leader>b :vert sb<CR><C-w>l
nmap <leader>n :sp<CR><C-w>j
nmap <leader>q :Prettier<CR>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map <leader>tn :tabnew<CR>
map <leader>ty :tabnext<CR>
map <leader>tr :tabprevious<CR>
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
map <C-p> :GFiles<CR>
map <leader>f :Files<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile "Enable :Prettier command
command! FormatJSON :execute '%!python -m json.tool' | w  

" Fzf with preview windows (Gfiles for gitfiles, Files for the whole system)
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Integrated terminal

set termguicolors  " Make colors look better in terminal
