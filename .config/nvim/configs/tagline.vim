set showtabline=2

function! GitBranchName()
  let a:gitPath = getcwd() . '/.git'
  if isdirectory(a:gitPath)
    let a:ref = system('cat ' . a:gitPath . '/HEAD')
    return a:ref[16:strlen(a:ref)-2]
  else
    return 'N/A'
  endif
endfunction

function! GitDirty()
  if !isdirectory(getcwd() . '/.git')
    return ''
  endif

  let a:dirty = system('git status 2>/dev/null | tail -n 1')

  if a:dirty == 'nothing to commit (working directory clean)'
    return ''
  else
    return '*'
  endif
endfunction

set tabline=
set tabline+=%2*\ \ %{GitBranchName()}%{GitDirty()}\ 
set tabline+=%4*
set tabline+=%0*
