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

let s:None = 'NONE'

let s:Black = '0'
let s:Gray = '8'
let s:GrayLight = 'darkgray'
let s:White = '15'

let s:Red = '1'
let s:Green = '2'
let s:Yellow = '3'
let s:Blue = '4'
let s:Magenta = '5'
let s:Cyan = '6'

function! s:HL(group, fg, bg, attr)
  exec "hi " . a:group . " ctermfg=" . a:fg . " ctermbg=" . a:bg . " cterm=" . a:attr
endfunction

" Base
call s:HL('Normal', s:White, s:None, s:None)
call s:HL('NormalNC', s:Blue, s:None, s:None)
call s:HL('VertSplit', s:None, s:None, s:None)
call s:HL('Whitespace', s:GrayLight, s:None, s:None)

" Status
call s:HL('StatusLine', s:Black, s:Yellow, s:None)
call s:HL('StatusLineNC', s:Yellow, s:Gray, s:None)
call s:HL('BufferAttribute', s:White, s:Red, s:None)

" Cursor
call s:HL('Cursor', s:None, s:None, s:None)
call s:HL('CursorLine', s:None, s:Gray, s:None)
call s:HL('CursorColumn', s:None, s:None, s:None)
call s:HL('CursorLineNr', s:White, s:Gray, s:None)
call s:HL('LineNr', s:GrayLight, s:None, s:None)

" Selection
call s:HL('Visual', s:Black, s:Yellow, s:None)

" Search/Matches
call s:HL('Search', s:Red, s:Yellow, s:None)
call s:HL('IncSearch', s:Black, s:Yellow, s:None)
call s:HL('MatchParen', s:Black, s:Yellow, s:None)

" Ruler
call s:HL('ColorColumn', s:None, s:Gray, s:None)

" Float
call s:HL('NormalFloat', s:White, s:Gray, s:None)
call s:HL('FloatBorder', s:White, s:Gray, s:None)

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
call s:HL('Float', s:None, s:None, s:None)
call s:HL('ErrorMsg', s:Black, s:Red, s:None)
call s:HL('WarningMsg', s:Black, s:Yellow, s:None)
call s:HL('DiagnosticUnnecessary', s:Yellow, s:None, s:None)

" Popup Menu
call s:HL('Pmenu', s:White, s:Gray, s:None)
call s:HL('PmenuSel', s:Black, s:Yellow, s:None)

" Markup
call s:HL('Todo', s:None, s:Green, 'bold')
call s:HL('Folded', s:Yellow, s:Gray, s:None)
call s:HL('NonText', s:Gray, s:None, s:None)
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
call s:HL('DiffChange', s:None, s:Yellow, s:None)
call s:HL('DiffDelete', s:None, s:Red, s:None)
call s:HL('DiffText', s:Gray, s:Blue, s:None)

if &diff
 call s:HL('DiffAdd', s:None, s:Green, s:None)
 call s:HL('DiffChange', s:None, s:Yellow, s:None)
 call s:HL('DiffDelete', s:Yellow, s:Red, s:None)
 call s:HL('DiffText', s:Gray, s:Blue, s:None)
else
 call s:HL('DiffAdd', s:Green, s:None, s:None)
 call s:HL('DiffChange', s:Yellow, s:None, s:None)
 call s:HL('DiffDelete', s:Yellow, s:None, s:None)
 call s:HL('DiffText', s:None, s:Blue, s:None)
endif
