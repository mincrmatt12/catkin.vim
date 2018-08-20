" Create bindings

command! -nargs=0 CaConfig call catkinvim#CVConfig()
command! -nargs=0 CaWstool call catkinvim#CVWstool()
command! -nargs=0 CaBuild  call catkinvim#CVBuild()

augroup catkinvim
    autocmd!
    autocmd BufRead * :call catkinvim#CVMakePrg()
augroup END
