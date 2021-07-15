" Configure linting
let g:ale_linters={
\   'c': ['clangtidy', 'cppcheck', 'clang-format'],
\   'cpp': ['clangtidy', 'cppcheck', 'clang-format'],
\}
let g:ale_fixers={
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'c': ['clangtidy', 'cppcheck', 'clang-format'],
\   'cpp': ['clangtidy', 'cppcheck', 'clang-format'],
\}
let g:ale_linters_explicit=1
let g:ale_c_parse_compile_commands=1
let g:ale_set_balloons=1
