" Only run checks when saving
let g:ale_lint_on_text_changed = 'never'

" List of linters
let g:ale_linters = {'c': ['clangtidy'], 'cpp': ['clangtidy']}

" Path can be fixed using a compile_commands.json file, or possibly using
" :let g:ale_cpp_clangtidy_options = '-- -I04_Libs/TargetLib_E4/03_Sources/modules/ -I04_Libs/TargetLib_E4/03_Sources/Headers -I03_Sources/Headers -I04_Libs/TargetLib_E4/03_Sources/Headers/Init -DTARGET_5924C005_Master'
