section .text
  global _start

_start:
  push dword len
  push dword msg
  push dword 1

  mov eax, 0x4
  sub esp, 4
  int 0x80

  push dword 9
  push dword s2
  push dword 1

  mov eax, 0x4
  sub esp, 4
  int 0x80

  push dword 0

  mov eax, 0x1
  sub esp, 4
  int 0x80

section .data
  msg db "Displaying 9 stars", 0xa
  len equ $-msg
  s2 times 9 db '*'
