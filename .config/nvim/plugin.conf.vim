"------Plugins config------"

" Specify a directory for plugins
call plug#begin()

" Make sure you use single quotes
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
Plug 'folke/which-key.nvim'
Plug 'github/copilot.vim'

" Initialize plugin system
call plug#end()

" Set leader key
let mapleader=','

" Clear autocmd group before add
autocmd!

" NERDTree
noremap <leader>nt :NERDTreeToggle<CR>
noremap <leader>nm :NERDTreeMirror<CR>
noremap <leader>nf :NERDTreeFind<CR>
" Open NERDTree when nvim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc()==1 && isdirectory(argv()[0]) &&
  \ !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeWinSize=35
let g:NERDTreePatternMatchHighlightFullName=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let g:NERDDefaultAlign='left'
let g:NERDCustomDelimiters={ 'c': { 'left': '/**','right': '*/' } }
let g:NERDTreeChDirMode=2
let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinPos='left'

" NERDTree Commenter
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1

" vim airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#tabline#formatter='default'

" Get rid of scratch buffer
set completeopt-=preview

" GitGutter
let g:gitgutter_max_signs=2000

" Floatterm
let g:floaterm_keymap_new='<leader>tc'
let g:floaterm_keymap_prev='<leader>tp'
let g:floaterm_keymap_next='<leader>tn'
let g:floaterm_keymap_toggle='<leader>tt'
let g:floaterm_width=0.8
let g:floaterm_height=0.8

" fzf
noremap <leader>fa :Ag<CR>
noremap <leader>ff :GFiles<CR>
noremap <leader>fz :FZF<CR>

" CoC
let g:coc_global_extensions=[ 'coc-docker', 'coc-rust-analyzer', 'coc-pyright',
  \ 'coc-sql', 'coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json',
  \ 'coc-prettier']
inoremap <silent><expr> <C-space> coc#refresh()

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

nmap <silent> gd :call CocActionAsync('jumpDefinition', 'vsplit')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>fb <Plug>(coc-format)
vmap <leader>fb <Plug>(coc-format-selected)

nnoremap <leader>doc :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Rust vim
let g:rustfmt_autosave=1

" Which key
lua << EOF
require("which-key").setup {}
EOF

" Catppuccin
lua << EOF
local catppuccin = require("catppuccin")
catppuccin.setup({
  term_colors = true
})
EOF
let g:catppuccin_flavour = "latte" " latte, frappe, macchiato, mocha
colorscheme catppuccin

" lualine
lua << END
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '::', right = '- '},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END
"------End plugins config------"
