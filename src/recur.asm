%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

section .data
msg: db "Factorial 3 is: "
  .len equ $ - msg
nl db 0xa

section .bss
  fact resb 1

section .text
  global _main

_main:
  mov bx, 3
  call proc_fact
  add ax, "0"
  mov [fact], ax

_print:
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg.len
  syscall

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, fact
  mov rdx, 1
  syscall

  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, nl
  mov rdx, 1
  syscall

_exit:
  mov rax, SYS_EXIT
  mov rdi, 0
  syscall

proc_fact:
  cmp bl, 1
  jg do_calculation
  mov ax, 1
  ret

do_calculation:
  dec bl
  call proc_fact
  inc bl
  mul bl
  ret
