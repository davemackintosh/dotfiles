set showtabline=2

function! GitBranchName()
  let s:gitPath = getcwd() . '/.git'
  if isdirectory(s:gitPath)
    let s:ref = system('cat ' . s:gitPath . '/HEAD')
    return s:ref[16:strlen(s:ref)-2]
  else
    return 'N/A'
  endif
endfunction

function! GitDirty()
  if !isdirectory(getcwd() . '/.git')
    return ''
  endif

  let s:dirty = system('git status 2>/dev/null | tail -n 1')

  if s:dirty == 'nothing to commit (working directory clean)'
    return ''
  else
    return '*'
  endif
endfunction

set tabline=
set tabline+=%1*\ \ %{GitBranchName()}%{GitDirty()}\ 
set tabline+=%5*
set tabline+=%0*
