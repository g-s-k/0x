section .text
  global _start

_start:
  push dword 1
  push dword choice
  push dword 1
  mov eax, 4
  sub esp, 4
  int 0x80

  mov eax, 1
  mov ebx, 0
  int 0x80

section .data
  choice db "y"
