scriptencoding utf-8

augroup ReloadTheme
  autocmd!
  autocmd BufWritePost mono.vim colorscheme mono
augroup end

hi clear
syntax reset
let g:colors_name="mono"
set background=dark
set t_Co=256

function! s:HL(group, fg, bg, attr)
  exec "hi " . a:group . " ctermfg=" . a:fg . " ctermbg=" . a:bg . " cterm=" . a:attr
endfunction

let s:None = 'NONE'
let s:Black = '0'
let s:White = '15'

let s:Gray = '7'
let s:DarkGray = '8'

let s:Ruler = '234'
let s:Cursor = '234'
let s:Whitespace = '237'

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

" Base
call s:HL('Normal', s:White, s:None, s:None)
call s:HL('NormalNC', s:Gray, s:None, s:None)
call s:HL('VertSplit', s:Gray, s:None, s:None)
call s:HL('Whitespace', s:Whitespace, s:None, s:None)

" Status
call s:HL('StatusLine', s:Black, s:Yellow, s:None)
call s:HL('StatusLineNC', s:Black, s:DarkGray, s:None)
call s:HL('BufferAttribute', s:White, s:Red, s:None)

" Cursor
call s:HL('Cursor', s:None, s:None, s:None)
call s:HL('CursorLine', s:None, s:Cursor, s:None)
call s:HL('CursorLineNr', s:Cursor, s:DarkGray, s:None)
call s:HL('CursorColumn', s:None, s:Cursor, s:None)
call s:HL('LineNr', s:DarkGray, s:None, s:None)
call s:HL('ColorColumn', s:None, s:Ruler, s:None)

" Selection
call s:HL('Visual', s:Black, s:Green, s:None)

" Search/Matches
call s:HL('Search', s:Black, s:Yellow, s:None)
call s:HL('MatchParen', s:Black, s:Yellow, s:None)

" Float
call s:HL('Float', s:None, s:None, s:None)
call s:HL('NormalFloat', s:White, s:Black, s:None)
hi link FloatBorder NormalFloat

" Telescope
" https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua#L11
hi link TelescopeNormal NormalFloat
hi link TelescopeResultsComment BufferAttribute

" Gutter
call s:HL('FoldColumn', s:None, s:Black, s:None)
call s:HL('SignColumn', s:None, s:Black, s:None)
call s:HL('GitGutterAdd', s:Green, s:None, s:None)
call s:HL('GitGutterChange', s:Yellow, s:None, s:None)
call s:HL('GitGutterDelete', s:Red, s:None, s:None)

" Diagnostics
call s:HL('ErrorMsg', s:Black, s:Red, s:None)
call s:HL('WarningMsg', s:Black, s:Green, s:None)
call s:HL('DiagnosticUnnecessary', s:Green, s:None, s:None)

" Popup Menu
call s:HL('Pmenu', s:White, s:DarkGray, s:None)
call s:HL('PmenuSel', s:Black, s:Green, s:None)

" Markup
call s:HL('Todo', s:None, s:Green, 'bold')
call s:HL('Folded', s:Green, s:DarkGray, s:None)
call s:HL('NonText', s:DarkGray, s:None, s:None)
call s:HL('Underlined', s:None, s:None, 'underline')

" Spelling
call s:HL('SpellBad', s:Red, s:None, 'italic,undercurl')
call s:HL('SpellCap', s:None, s:None, 'italic,undercurl')
call s:HL('SpellLocal', s:None, s:None, 'undercurl')

" Language
call s:HL('Comment', s:Green, s:None, s:None)
call s:HL('Define', s:None, s:None, s:None)
call s:HL('Boolean', s:None, s:None, s:None)
call s:HL('Constant', s:None, s:None, s:None)
call s:HL('Character', s:None, s:None, s:None)
call s:HL('Conditional', s:Magenta, s:None, s:None)
call s:HL('Function', s:None, s:None, s:None)
call s:HL('Identifier', s:None, s:None, s:None)
call s:HL('Keyword', s:Magenta, s:None, s:None)
call s:HL('Label', s:None, s:None, s:None)
call s:HL('Number', s:None, s:None, s:None)
call s:HL('Operator', s:Magenta, s:None, s:None)
call s:HL('PreProc', s:Magenta, s:None, s:None)
call s:HL('Special', s:None, s:None, s:None)
call s:HL('SpecialKey', s:None, s:None, s:None)
call s:HL('Statement', s:None, s:None, s:None)
call s:HL('StorageClass', s:None, s:None, s:None)
call s:HL('String', s:None, s:None, s:None)
call s:HL('Tag', s:Cyan, s:None, s:None)
call s:HL('Title', s:None, s:None, 'bold')
call s:HL('Type', s:None, s:None, s:None)

" Diff
call s:HL('DiffAdd', s:None, s:Green, s:None)
call s:HL('DiffChange', s:None, s:Green, s:None)
call s:HL('DiffDelete', s:None, s:Red, s:None)
call s:HL('DiffText', s:DarkGray, s:Blue, s:None)

if &diff
 call s:HL('DiffAdd', s:None, s:Green, s:None)
 call s:HL('DiffChange', s:None, s:Green, s:None)
 call s:HL('DiffDelete', s:Green, s:Red, s:None)
 call s:HL('DiffText', s:DarkGray, s:Blue, s:None)
else
 call s:HL('DiffAdd', s:Green, s:None, s:None)
 call s:HL('DiffChange', s:Green, s:None, s:None)
 call s:HL('DiffDelete', s:Green, s:None, s:None)
 call s:HL('DiffText', s:None, s:Blue, s:None)
endif
