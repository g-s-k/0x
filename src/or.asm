%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

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
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, res
  mov rdx, 1
  syscall
  jmp print_newline

print_newline:
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall
  jmp exit

exit:
  mov rax, SYS_EXIT
  mov rdi, 0
  syscall

