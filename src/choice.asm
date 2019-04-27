section .text
  global _main

_main:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, choice
  mov rdx, 1
  syscall

  mov eax, 0x2000001
  mov rdi, 0
  syscall

section .data
  choice db "y"
