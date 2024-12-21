augroup ReloadTheme
  autocmd!
  autocmd BufWritePost mono.vim colorscheme mono
augroup end

source $VIMRUNTIME/colors/vim.lua
let g:colors_name="mono"

let s:t_Co = &t_Co

hi clear
syntax reset
set background=dark

function! s:HL(group, fg, bg, attr)
  exec "hi " . a:group . " ctermfg=" . a:fg . " ctermbg=" . a:bg . " cterm=" . a:attr
endfunction

let s:_ = 'NONE'

let s:Black = '0'
let s:White = '15'

let s:Gray = '7'
let s:DarkGray = '8'

let s:Red = '1'
let s:BrightRed = '9'
let s:Green = '2'
let s:BrightGreen = '10'
let s:Yellow = '3'
let s:BrightYellow = '11'
let s:Blue = '4'
let s:BrightBlue = '12'
let s:Magenta = '5'
let s:BrightMagenta = '13'
let s:Cyan = '6'
let s:BrightCyan = '14'

let s:Ruler = '234'
let s:Cursor = '234'
let s:Whitespace = '237'
let s:Float = '238'

" Base
call s:HL('Normal', s:White, s:_, s:_)
call s:HL('NormalNC', s:Gray, s:Ruler, s:_)
call s:HL('VertSplit', s:Gray, s:_, s:_)
call s:HL('Whitespace', s:Whitespace, s:_, s:_)

" Status
call s:HL('StatusLine', s:Black, s:Yellow, s:_)
call s:HL('StatusLineNC', s:Black, s:DarkGray, s:_)
call s:HL('BufferAttribute', s:White, s:Red, s:_)

" Cursor
call s:HL('Cursor', s:_, s:_, s:_)
call s:HL('CursorLine', s:_, s:Cursor, s:_)
call s:HL('CursorLineNr', s:Cursor, s:DarkGray, s:_)
call s:HL('CursorColumn', s:_, s:Cursor, s:_)
call s:HL('LineNr', s:DarkGray, s:_, s:_)
call s:HL('ColorColumn', s:_, s:Ruler, s:_)

" Selection
call s:HL('Visual', s:Black, s:Yellow, s:_)

" Search/Matches
call s:HL('Search', s:Black, s:Green, s:_)
call s:HL('MatchParen', s:Black, s:Cyan, s:_)

" Float
call s:HL('Float', s:_, s:_, s:_)
call s:HL('NormalFloat', s:White, s:Float, s:_)
hi link FloatBorder NormalFloat

" Telescope
" https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua#L11
hi link TelescopeNormal NormalFloat
hi link TelescopeResultsComment BufferAttribute

" Gutter
call s:HL('FoldColumn', s:_, s:Black, s:_)
call s:HL('SignColumn', s:_, s:Black, s:_)
call s:HL('GitGutterAdd', s:Green, s:_, s:_)
call s:HL('GitGutterChange', s:Yellow, s:_, s:_)
call s:HL('GitGutterDelete', s:Red, s:_, s:_)

" Diagnostics
call s:HL('ErrorMsg', s:Black, s:Red, s:_)
call s:HL('WarningMsg', s:Black, s:Yellow, s:_)
call s:HL('DiagnosticUnnecessary', s:Yellow, s:_, s:_)

" Popup Menu
call s:HL('Pmenu', s:White, s:Float, s:_)
call s:HL('PmenuSel', s:Black, s:Yellow, s:_)

" Markup
call s:HL('Todo', s:_, s:Yellow, 'bold')
call s:HL('Folded', s:DarkGray, s:Ruler, s:_)
call s:HL('NonText', s:DarkGray, s:_, s:_)
call s:HL('Underlined', s:_, s:_, 'underline')

" Spelling
call s:HL('SpellBad', s:Red, s:_, 'italic,undercurl')
call s:HL('SpellCap', s:_, s:_, 'italic,undercurl')
call s:HL('SpellLocal', s:_, s:_, 'undercurl')

" Language
let s:Comment = s:Green
let s:Reserved = s:Magenta
let s:Markup = s:BrightBlue
call s:HL('Comment', s:Green, s:_, s:_)
call s:HL('Define', s:_, s:_, s:_)
call s:HL('Boolean', s:_, s:_, s:_)
call s:HL('Constant', s:_, s:_, s:_)
call s:HL('Character', s:_, s:_, s:_)
call s:HL('Conditional', s:Reserved, s:_, s:_)
call s:HL('Function', s:_, s:_, s:_)
call s:HL('Identifier', s:_, s:_, s:_)
call s:HL('Keyword', s:Reserved, s:_, s:_)
call s:HL('Label', s:_, s:_, s:_)
call s:HL('Number', s:_, s:_, s:_)
call s:HL('Operator', s:Reserved, s:_, s:_)
call s:HL('PreProc', s:Reserved, s:_, s:_)
call s:HL('Special', s:_, s:_, s:_)
call s:HL('SpecialKey', s:_, s:_, s:_)
call s:HL('Statement', s:Reserved, s:_, s:_)
call s:HL('StorageClass', s:_, s:_, s:_)
call s:HL('String', s:_, s:_, s:_)
call s:HL('Tag', s:Markup, s:_, s:_)
call s:HL('Title', s:_, s:_, 'bold')
call s:HL('Type', s:_, s:_, s:_)

" Diff
call s:HL('DiffText', s:_, s:_, s:_)
call s:HL('DiffAdd', s:_, s:Green, s:_)
call s:HL('DiffChange', s:_, s:Yellow, s:_)
call s:HL('DiffDelete', s:_, s:Red, s:_)
