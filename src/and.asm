section .data
even_msg: db  "Even Number!"
  .len equ  $ - even_msg
odd_msg:  db  "Odd Number!"
  .len equ  $ - odd_msg
newline db 0xa

section .text
  global _main

_main:
  mov ax, 9h
  and ax, 1
  jz if_even

  mov rsi, odd_msg
  mov rdx, odd_msg.len
  jmp print_msg

if_even:
  mov rsi, even_msg
  mov rdx, even_msg.len
  jmp print_msg

print_msg:
  mov rax, 0x2000004
  mov rdi, 1
  syscall
  jmp print_newline

print_newline:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall
  jmp exit

exit:
  mov rax, 0x2000001
  mov rdi, 0
  syscall

