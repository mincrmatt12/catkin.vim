" catkin.vim
"
" autoload
"
" utilities to move catkin files around properly.

" GetCatkinRootDir

function! s:GetCatkinRootDir()
	let l:curdir = expand('%:h')
	while l:curdir =~ "/"
		if filereadable(l:curdir . "/.catkin_tools/README")
			return l:curdir
		endif
		let l:curdir = fnamemodify(l:curdir, ':h')
	endwhile
	if filereadable(l:curdir . "/.catkin_tools/README")
		return l:curdir
	endif
	return ""
endfunction

function! s:ListPackages(rootdir)
	let l:pathdir = a:rootdir . "/src"
	let l:packages = []
	for p in split(globpath(pathdir, '*'), '\n')
		if filereadable(p . "/package.xml")
			let l:packages += [fnamemodify(p, ':t')]
		endif
	endfor
	return l:packages
endfunction

function! catkinvim#CVConfig()
	let l:rootdir = s:GetCatkinRootDir()
	execute '!cd ' . l:rootdir . '; catkin config --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1; catkin build --force-cmake'

	for pname in s:ListPackages(l:rootdir)
		" Link the catkin tools
		if filereadable(l:rootdir . "/build/" . pname . "/compile_commands.json")
			execute '!ln -sf ' . fnamemodify(l:rootdir . '/build/' . pname . "/compile_commands.json", ':p') . " " . l:rootdir . "/src/" . pname . "/compile_commands.json"
		endif
	endfor
endfunction

function! catkinvim#CVMakePrg()
	let l:rootdir = s:GetCatkinRootDir() 
	if l:rootdir != ""
		let &makeprg = 'cd ' . l:rootdir . '; catkin build'
	endif
endfunction

function! catkinvim#CVWstool()
	let l:rootdir = s:GetCatkinRootDir() 
	execute '!cd ' . l:rootdir . '/src; wstool update'
endfunction
