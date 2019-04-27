section .text
  global _main

_main:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg.len
  syscall

  mov rax, 0x2000001
  mov rdi, 0
  syscall

section .data
msg:  db "hello, world", 10
  .len equ $ - msg
