%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

section .bss
  num resb 1

section	.text
  global _main

_main:
  mov rcx, 10

l1:
  mov byte [rel num], ":"
  sub [rel num], rcx

  push rcx

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, num
  mov rdx, 1
  syscall

  pop rcx
  loop l1

  mov rax, SYS_EXIT
  mov rdi, 0
  syscall
