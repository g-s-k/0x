%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

section .data
  nl db 0xa

section .bss
  achar resb 1

section .text
  global _main

_main:
  call display
  call newline

_exit:
  mov rax, SYS_EXIT
  mov rdi, 0
  syscall

display:
  mov rcx, 0x20

next:
  mov [achar], rcx
  push rcx

  mov rsi, achar
  call print_one

  pop rcx
  inc rcx
  cmp rcx, 0x80
  jl next
  ret

newline:
  mov rsi, nl
  call print_one
  ret

print_one:
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rdx, 1
  syscall
  ret
