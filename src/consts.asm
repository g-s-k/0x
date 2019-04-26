SYS_CALL equ 128
SYS_EXIT equ 1
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

section .text
  global _start

_start:
  push dword len1
  push dword msg1
  push dword STDOUT
  mov eax, SYS_WRITE
  sub esp, 4
  int SYS_CALL

  push dword len2
  push dword msg2
  push dword STDOUT
  mov eax, SYS_WRITE
  sub esp, 4
  int SYS_CALL

  push dword len3
  push dword msg3
  push dword STDOUT
  mov eax, SYS_WRITE
  sub esp, 4
  int SYS_CALL

  push dword len4
  push dword msg4
  push dword STDOUT
  mov eax, SYS_WRITE
  sub esp, 4
  int SYS_CALL

  mov eax, SYS_EXIT
  int SYS_CALL

section .data
  msg1 db "Hello.", 0xA, 0xD
  len1 equ $-msg1

  msg2 db "You now find yourself in a world of...", 0xA, 0xD
  len2 equ $-msg2

  msg3 db "pain, or more accurately...", 0xA, 0xD
  len3 equ $-msg3

  msg4 db "assembly programming.", 0xA
  len4 equ $-msg3
