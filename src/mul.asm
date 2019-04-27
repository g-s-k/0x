section .data
msg: db "The result is: "
  .len equ $ - msg
nl db 0xa

section .bss
  res resb 1

section .text
  global _main

_main:
  ;; get actual 3 and 2 in registers
  mov al, "3"
  sub al, "0"
  mov bl, "2"
  sub bl, "0"

  ;; multiply
  mul bl

  ;; ascii-ify and save
  add al, "0"
  mov [rel res], al

  ;; print message
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, msg
  mov rdx, msg.len
  syscall

  ;; print result
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, res
  mov rdx, 1
  syscall

  ;; print newline
  mov rax, 0x2000004
  mov rdi, 1
  mov rsi, nl
  mov rdx, 1
  syscall

  ;; exit
  mov rax, 0x2000001
  mov rdi, 0
  syscall
