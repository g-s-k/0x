section .data
newline db 0xa

section .bss
  res resb 1

section .text
  global _main

_main:
  mov al, 5
  mov bl, 3
  or al, bl

  add al, "0"
  mov [rel res], al

  jmp print_res

print_res:
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, res
  mov rdx, 1
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

