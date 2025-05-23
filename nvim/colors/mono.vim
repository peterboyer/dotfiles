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

let s:Grey = '7'
let s:DarkGrey = '8'

let s:Red = '1'
let s:Green = '2'
let s:Yellow = '3'
let s:Blue = '4'
let s:Purple = '5'
let s:Teal = '6'
let s:Orange = '166'

let s:Cursor = '234'
let s:Whitespace = '238'
let s:Float = '237'

" Base
"
call s:HL('Normal', s:_, s:_, s:_)
call s:HL('NormalNC', s:Grey, s:Cursor, s:_)
call s:HL('VertSplit', s:_, s:_, s:_)
call s:HL('Whitespace', s:Whitespace, s:_, s:_)

" Status
call s:HL('StatusLine', s:Black, s:White, s:_)
call s:HL('StatusLineNC', s:Black, s:DarkGrey, s:_)
call s:HL('Modified', s:_, s:Red, s:_)
call s:HL('BufferAttribute', s:DarkGrey, s:_, s:_)

" Cursor
call s:HL('Cursor', s:_, s:_, s:_)
call s:HL('CursorLine', s:_, s:Cursor, s:_)
call s:HL('CursorLineNr', s:Orange, s:Cursor, s:_)
call s:HL('CursorColumn', s:_, s:Cursor, s:_)
call s:HL('LineNr', s:DarkGrey, s:_, s:_)
call s:HL('ColorColumn', s:_, s:Cursor, s:_)

" Selection
call s:HL('Visual', s:Black, s:Yellow, s:_)

" Search/Matches
call s:HL('Search', s:Black, s:Green, s:_)
call s:HL('MatchParen', s:Black, s:Teal, s:_)

" Float
call s:HL('Float', s:_, s:_, s:_)
call s:HL('NormalFloat', s:White, s:Float, s:_)
hi link FloatBorder NormalFloat
hi link LazyGitFloat NormalFloat
hi link LazyGitBorder NormalFloat

" Telescope
" https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua#L11
hi link TelescopeNormal NormalFloat
hi link TelescopeResultsComment BufferAttribute

" Gutter
call s:HL('FoldColumn', s:_, s:_, s:_)
call s:HL('SignColumn', s:_, s:_, s:_)
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
call s:HL('Folded', s:Teal, s:_, s:_)
call s:HL('NonText', s:DarkGrey, s:_, s:_)
call s:HL('Underlined', s:_, s:_, 'underline')

" Spelling
call s:HL('SpellBad', s:Red, s:_, 'italic,undercurl')
call s:HL('SpellCap', s:_, s:_, 'italic,undercurl')
call s:HL('SpellLocal', s:_, s:_, 'undercurl')

" Language
let s:Comment = s:Green
let s:Reserved = s:Purple " Keywords/Operators/etc.
let s:String = s:Grey
let s:Tag = s:Teal " HTML/JSX

call s:HL('Comment', s:Comment, s:_, s:_)
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
call s:HL('String', s:String, s:_, s:_)
call s:HL('Tag', s:Tag, s:_, s:_)
call s:HL('Title', s:_, s:_, 'bold')
call s:HL('Type', s:_, s:_, s:_)

" Diff
call s:HL('DiffText', s:_, s:_, s:_)
call s:HL('DiffAdd', s:_, s:Green, s:_)
call s:HL('DiffChange', s:_, s:Yellow, s:_)
call s:HL('DiffDelete', s:_, s:Red, s:_)
