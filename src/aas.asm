%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

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

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg.len
  syscall

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, res
  mov rdx, 1
  syscall

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, nl
  mov rdx, 1
  syscall

  mov rax, SYS_EXIT
  mov rdi, 0
  syscall
