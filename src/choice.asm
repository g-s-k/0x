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
  mov rsi, choice
  mov rdx, 1
  syscall

  mov eax, SYS_EXIT
  mov rdi, 0
  syscall

section .data
  choice db "y"
