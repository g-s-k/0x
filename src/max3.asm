%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

section .data
msg:   db "The highest leading digit belongs to: "
  .len equ $ - msg
num0 db "22"
num1 db "47"
num2 db "31"
numlen equ 2
newline db 0xa

section .bss
  largest resb 2

section .text
  global _main

_main:
  mov r8, num0
  mov r9, num1

  mov r10, [r8]
  and r10, 0xf
  mov r11, [r9]
  and r11, 0xf

  cmp r10, r11
  jg check_third_num

  mov r8, r9

check_third_num:
  mov r9, num2

  mov r10, [r8]
  and r10, 0xf
  mov r11, [r9]
  and r11, 0xf

  cmp r10, r11
  jg _exit

  mov r8, r9

_exit:
  mov r9, [r8]
  mov [rel largest], r9

  ;; print message
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg.len
  syscall

  ;; print result
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, largest
  mov rdx, numlen
  syscall

  ;; print newline
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall

  mov rax, SYS_EXIT
  mov rdi, 0
  syscall
