"TO USE:
"
"Enter :SetupHeadspaceCoPilot into your vim commandline to create the
"`in` pipe file and start the netcat connection.
"
"On the other side, call `while [ 1 ]; do nc localhost 8080; done` and
"watch the contents of the current editor buffer be joined into one line
"and be sent across the wire.
"
"TODO: Encode new lines so that the lines can be split appropriately.

function! s:echo()
  call system("echo " . shellescape(join(getline(1,"$"))) . " > in")
endfunction

command! EchoHeadspaceCoPilot call s:echo()

function! s:setup()
  call system("if [ ! -e in ]; then mkfifo in; fi")
  call system("while [ 1 ]; do nc -l localhost 8080 < in > /dev/null; done &")
  autocmd CursorMoved * EchoHeadspaceCoPilot
  autocmd CursorMovedI * EchoHeadspaceCoPilot
endfunction

command! SetupHeadspaceCoPilot call s:setup()
