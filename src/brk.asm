%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_BRK 12
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

section .text
  global _main

_main:
  mov rax, SYS_BRK
  xor rdi, rdi
  syscall

  cmp rax, 0
  jl _exit_bad

  add rax, 0x4000
  mov rdi, rax
  mov rax, SYS_BRK
  syscall

  cmp rax, 0
  jl _exit_bad

  mov rdi, rax
  sub rdi, 4
  mov rcx, 4096
  xor rax, rax

  std
  rep stosd
  cld

_exit_good:
  xor rdi, rdi
  jmp _exit
_exit_bad:
  mov rdi, rax
_exit:
  mov rax, SYS_EXIT
  syscall
