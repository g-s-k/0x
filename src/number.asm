%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_READ 0
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_READ 0x2000003
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

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
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, userMsg
  mov rdx, lenUserMsg
  syscall

  ;; read input
  mov rax, SYS_READ
  mov rdi, 2
  mov rsi, num
  mov rdx, 5
  syscall

  ;; show text before result
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, dispMsg
  mov rdx, lenDispMsg
  syscall

  ;; display result
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, num
  mov rdx, 5
  syscall

  ;; exit
  mov rax, SYS_EXIT
  mov rdi, 0
  syscall
