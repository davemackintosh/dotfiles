call defx#custom#option('_', {
\ 'winwidth': 40,
\ 'split': 'vertical',
\ 'direction': 'topleft',
\ 'columns': 'indent:git:icons:filename:type',
\ 'show_ignored_files': 1,
\ 'toggle': 1,
\ })

let g:defx_git#indicators = {
	\ 'Modified'  : '•',
	\ 'Staged'    : '✚',
	\ 'Untracked' : 'ᵁ',
	\ 'Renamed'   : '≫',
	\ 'Unmerged'  : '≠',
	\ 'Ignored'   : 'ⁱ',
	\ 'Deleted'   : '✖',
	\ 'Unknown'   : '⁇'
	\ }
