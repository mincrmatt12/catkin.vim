" Create bindings

command! -nargs=0 CaConfig call catkinvim#CVConfig()
command! -nargs=0 CaWstool call catkinvim#CVWstool()

augroup catkinvim
    autocmd!
    autocmd BufRead * :call catkinvim#CVMakePrg()
augroup END
