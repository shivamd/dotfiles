runtime macros/matchit.vim
syntax on
execute pathogen#infect()
filetype plugin indent on
set relativenumber
set backspace=2
set tabstop=2
set shiftwidth=2
set showmode " Display the mode you are in.
set wildmenu " Enchanced command line completion
set wildmode=list:longest " complete files like a shell
set ignorecase 
set smartcase " but case sensitive if expression contains a capital letter
set ruler " show cursor position
set visualbell 
set noswapfile
set smartindent
set expandtab
set autoindent
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set incsearch " Highlight when searching
set hlsearch " highlight all matches after search
set laststatus=2  " Always show status line.
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
set splitright
set splitbelow

set grepprg=ag " silver searcher instead of grep
nnoremap \ :Ag<SPACE>
let g:ackprg = 'ag --nogroup --nocolor --column'
"Syntax highlighting
au BufNewFile,BufRead *.ejs set filetype=html
autocmd BufRead,BufNewFile *.md set filetype=markdown
filetype plugin indent on

"Enable spell check for markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" Git commit messages.
autocmd Filetype gitcommit setlocal spell textwidth=72

"Display extra whitespace
set list listchars=tab:»·,trail:·

let mapleader=","
map <Leader>d odebugger<cr><esc>:w<cr>
map <Leader>gm :vsp Gemfile<cr>
map <Leader>ro :vsp config/routes.rb<cr>
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
map <Leader>h :nohlsearch<cr>
map <Leader>i mmgg=G`m<CR>
map <Leader>l oconsole.log 'debugging'<esc>:w<cr>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map <Leader>sc :sp db/schema.rb<cr>


nnoremap <C-n> :call NumberToggle()<cr>
map <C-k> <esc>:w<cr>
imap <C-k> <esc>:w<cr>

"Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  elseif(&number == 1)
    set nonumber
  else
    set relativenumber
  endif
endfunc

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
" Snippets are activated by Shift+Tab
:imap <S-Tab> <Plug>snipMateNextOrTrigger
:smap <S-Tab> <Plug>snipMateNextOrTrigger
