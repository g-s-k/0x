%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

%macro write_string 1
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, %1
  mov rdx, %1.len
  syscall
%endmacro

%macro return 1
  mov rax, SYS_EXIT
  mov rdi, %1
  syscall
%endmacro

section .data
str0: db "This is the first string.", 0xa
  .len equ $ - str0
str1: db "This right here is the second string.", 0xa
  .len equ $ - str1
str2: db "And this is the last string.", 0xa
  .len equ $ - str2

section .text
  global _main

_main:
  write_string str0
  write_string str1
  write_string str2
  return 0
