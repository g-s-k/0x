section .data
  userMsg db "Please enter a number: "
  lenUserMsg equ $-userMsg
  dispMsg db "You entered the number "
  lenDispMsg equ $-dispMsg

section .bss
  num resb 5

section .text
  global _main

_main:
  ;; prompt for number
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, userMsg
  mov rdx, lenUserMsg
  syscall

  ;; read input
  mov rax, 0x2000003
  mov rdi, 2
  mov rsi, num
  mov rdx, 5
  syscall

  ;; show text before result
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, dispMsg
  mov rdx, lenDispMsg
  syscall

  ;; display result
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, num
  mov rdx, 5
  syscall

  ;; exit
  mov rax, 0x2000001
  mov rdi, 0
  syscall
