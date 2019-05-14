%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_READ 0
  %define SYS_WRITE 1
  %define SYS_OPEN 2
  %define SYS_CLOSE 3
  %define SYS_EXIT 60
  %define SYS_CREAT 85
  %define SYS_UNLINK 87
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

%define FILE_READ_BUFFER 30

section .data
file_name db "foobar.txt", 0
file_contents: db "this goes into the file", 0xa
  .len equ $ - file_contents

section .bss
  fd resq 1
  read_contents resb FILE_READ_BUFFER

section .text
  global _main

_main:
  call create_file
  call write_file
  call close_file

  call open_file
  call cat_file
  call close_file
  call delete_file

_exit_good:
  mov rdi, 0
  jmp _exit
_exit_bad:
  mov rdi, rax
_exit:
  mov rax, SYS_EXIT
  syscall

create_file:
  mov rax, SYS_CREAT
  mov rdi, file_name
  mov rsi, 420                  ; haha permissions am i right
  syscall

  cmp rax, 0
  jl _exit_bad
  mov [fd], rax
  ret

write_file:
  mov rax, SYS_WRITE
  mov rdi, [fd]
  mov rsi, file_contents
  mov rdx, file_contents.len
  syscall

  cmp rax, 0
  jl _exit_bad
  ret

close_file:
  mov rax, SYS_CLOSE
  mov rdi, [fd]
  syscall

  cmp rax, 0
  jl _exit_bad
  ret

open_file:
  mov rax, SYS_OPEN
  mov rdi, file_name
  mov rsi, 0
  mov rdx, 256                  ; only need read permissions
  syscall

  cmp rax, 0
  jl _exit_bad
  mov [fd], rax
  ret

cat_file:
  mov rax, SYS_READ
  mov rdi, [fd]
  mov rsi, read_contents
  mov rdx, FILE_READ_BUFFER
  dec rdx
  syscall

  cmp rax, 0
  jl _exit_bad

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, read_contents
  mov rdx, FILE_READ_BUFFER
  syscall

  cmp rax, 0
  jl _exit_bad
  ret

delete_file:
  mov rax, SYS_UNLINK
  mov rdi, file_name
  syscall

  cmp rax, 0
  jl _exit_bad
  ret
