SYS_EXIT equ 0x2000001
SYS_READ equ 0x2000003
SYS_WRITE equ 0x2000004

STDIN equ 0
STDOUT equ 1

section .data
  msg1 db "Enter a digit: ", 0xA, 0xD
  len1 equ $ - msg1

  msg2 db "Enter another digit: ", 0xA, 0xD
  len2 equ $ - msg2

  msg3 db "The sum is:", 0xA, 0xD
  len3 equ $ - msg3

  nl db "", 0xA

section .bss
  num1 resb 2
  num2 resb 2
  res resb 1

section .text
  global _main

_main:
  ;; first prompt
  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, msg1
  mov rdx, len1
  syscall

  ;; read first digit
  mov rax, SYS_READ
  mov rdi, STDIN
  mov rsi, num1
  mov rdx, 2
  syscall

  ;; second prompt
  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, msg2
  mov rdx, len2
  syscall

  ;; read second digit
  mov rax, SYS_READ
  mov rdi, STDIN
  mov rsi, num2
  mov rdx, 2
  syscall

  ;; subtract ascii zero so they're raw integers
  mov rax, [rel num1]
  sub rax, "0"
  mov rdi, [rel num2]
  sub rdi, "0"

  ;; add as integers, then add ascii zero
  add rax, rdi
  add rax, "0"
  mov [rel res], rax

  ;; result message
  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, msg3
  mov rdx, len3
  syscall

  ;; display sum
  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, res
  mov rdx, 1
  syscall

  ;; newline
  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, nl
  mov rdx, 1
  syscall

  ;; exit
  mov rax, SYS_EXIT
  mov rdi, 0
  syscall
