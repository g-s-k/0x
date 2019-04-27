section	.text
   global _main

_main:
  ;; print original form
  mov	rax, 0x2000004
  mov rdi, 1
  mov rsi, name
  mov rdx, 9
  syscall

  ;; change the first four chars
  mov	[rel name], dword "Nuha"

  ;; print it again
  mov	rax, 0x2000004
  mov rdi, 1
  mov rsi, name
  mov rdx, 8                  ; no trailing space
  syscall

  ;; newline
  mov	rax, 0x2000004
  mov rdi, 1
  mov rsi, nl
  mov rdx, 1
  syscall

  ;; exit
  mov	rax, 0x2000001
  syscall

section	.data
  name db "Zara Ali "
  nl db "", 0xa
