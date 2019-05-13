section .data
msg:  db "The result is: "
  .len equ $ - msg
nl db 0xa

section .bss
  res resb 1

section .text
  global _main

_main:
  mov al, "9"
  sub al, "3"
  or al, 0x30
  mov [rel res], ax

  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg.len
  syscall

  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, res
  mov rdx, 1
  syscall

  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, nl
  mov rdx, 1
  syscall

  mov rax, 0x2000001
  mov rdi, 0
  syscall
