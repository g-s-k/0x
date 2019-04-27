section .text
  global _main

_main:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, msg
  mov rdx, len
  syscall

  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, s2
  mov rdx, 9
  syscall

  mov rax, 0x2000001
  mov rdi, 0
  syscall

section .data
  msg db "Displaying 9 stars", 0xa
  len equ $-msg
  s2 times 9 db '*'
