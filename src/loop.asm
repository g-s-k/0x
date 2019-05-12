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

  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, num
  mov rdx, 1
  syscall

  pop rcx
  loop l1

  mov rax, 0x2000001
  mov rdi, 0
  syscall
