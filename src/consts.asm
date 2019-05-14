%ifidn __OUTPUT_FORMAT__, elf64
  SYS_EXIT equ 60
  SYS_WRITE equ 1
%elifidn __OUTPUT_FORMAT__, macho64
  SYS_EXIT equ 0x2000001
  SYS_WRITE equ 0x2000004
%endif

STDIN equ 0
STDOUT equ 1

section .text
  global _main

_main:
  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, msg1
  mov rdx, len1
  syscall

  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, msg2
  mov rdx, len2
  syscall

  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, msg3
  mov rdx, len3
  syscall

  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, msg4
  mov rdx, len4
  syscall

  mov rax, SYS_EXIT
  mov rdi, 0
  syscall

section .data
  msg1 db "Hello.", 0xA, 0xD
  len1 equ $-msg1

  msg2 db "You now find yourself in a world of...", 0xA, 0xD
  len2 equ $-msg2

  msg3 db "pain, or more accurately...", 0xA, 0xD
  len3 equ $-msg3

  msg4 db "assembly programming.", 0xA
  len4 equ $-msg3
