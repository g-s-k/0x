%ifidn __OUTPUT_FORMAT__, elf64
  %define SYS_WRITE 1
  %define SYS_EXIT 60
%elifidn __OUTPUT_FORMAT__, macho64
  %define SYS_WRITE 0x2000004
  %define SYS_EXIT 0x2000001
%endif

section	.text
   global _main

_main:
  ;; print original form
  mov	rax, SYS_WRITE
  mov rdi, 1
  mov rsi, name
  mov rdx, 9
  syscall

  ;; change the first four chars
  mov	[rel name], dword "Nuha"

  ;; print it again
  mov	rax, SYS_WRITE
  mov rdi, 1
  mov rsi, name
  mov rdx, 8                  ; no trailing space
  syscall

  ;; newline
  mov	rax, SYS_WRITE
  mov rdi, 1
  mov rsi, nl
  mov rdx, 1
  syscall

  ;; exit
  mov	rax, SYS_EXIT
  mov rdi, 0
  syscall

section	.data
  name db "Zara Ali "
  nl db "", 0xa
