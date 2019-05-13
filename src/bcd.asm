section .data
msg:  db "The result is: "
  .len equ $ - msg
num1 db "12345"
num2 db "23456"
sum times 5 db " "
newline db 0xa

section .text
  global _main

_main:
  mov rcx, 5
  clc

add_loop:
  lea rsi, [rel num1]
  mov al, [rsi + rcx - 1]

  lea rsi, [rel num2]
  adc al, [rsi + rcx - 1]

  pushf
  sub al, 0x30
  cmp al, 0x39
  jle write
  popf
  sub al, 10
  stc
  pushf

write:
  popf
  lea rsi, [rel sum]
  mov [rsi + rcx - 1], al

  loop add_loop

print_message:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg.len
  syscall

print_result:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, sum
  mov rdx, 5
  syscall

print_newline:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall

exit:
  mov rax, 0x2000001
  mov rdi, 0
  syscall
