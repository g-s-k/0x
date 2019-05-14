%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

section .data
  x db 2, 4, 3
  nl db 0xa

section .bss
  sum resb 1

section .text
  global _main

_main:
  mov rax, x
  mov rbx, 0
  mov rcx, 3

add_up:
  add rbx, [rax]
  inc rax
  loop add_up

  add rbx, "0"
  mov [sum], rbx

disp:
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, sum
  mov rdx, 1
  syscall

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, nl
  mov rdx, 1
  syscall

_exit:
  mov rax, SYS_EXIT
  mov rdi, 0
  syscall
