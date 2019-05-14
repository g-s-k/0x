%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

section .text
  global _main

_main:
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, msg
  mov rdx, len
  syscall

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, s2
  mov rdx, 9
  syscall

  mov rax, SYS_EXIT
  mov rdi, 0
  syscall

section .data
  msg db "Displaying 9 stars", 0xa
  len equ $-msg
  s2 times 9 db '*'
