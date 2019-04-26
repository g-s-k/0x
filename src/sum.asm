SYS_CALL equ 128
SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4

STDIN equ 0
STDOUT equ 1

section .data
  msg1 db "Enter a digit: ", 0xA, 0xD
  len1 equ $ - msg1

  msg2 db "Enter another digit: ", 0xA, 0xD
  len2 equ $ - msg2

  msg3 db "The sum is:", 0xA, 0xD
  len3 equ $ - msg3

  nl db "", 0xA

section .bss
  num1 resb 2
  num2 resb 2
  res resb 1

section .text
  global _start

_start:
  ;; first prompt
  push dword len1
  push dword msg1
  push dword STDOUT
  mov eax, SYS_WRITE
  sub esp, 4
  int SYS_CALL

  ;; read first digit
  push dword 2
  push dword num1
  push dword STDIN
  mov eax, SYS_READ
  sub esp, 4
  int SYS_CALL

  ;; second prompt
  push dword len2
  push dword msg2
  push dword STDOUT
  mov eax, SYS_WRITE
  sub esp, 4
  int SYS_CALL

  ;; read second digit
  push dword 2
  push dword num2
  push dword STDIN
  mov eax, SYS_READ
  sub esp, 4
  int SYS_CALL

  ;; subtract ascii zero so they're raw integers
  mov eax, [num1]
  sub eax, "0"
  mov ebx, [num2]
  sub ebx, "0"

  ;; add as integers, then add ascii zero
  add eax, ebx
  add eax, "0"
  mov [res], eax

  ;; result message
  push dword len3
  push dword msg3
  push dword STDOUT
  mov eax, SYS_WRITE
  sub esp, 4
  int SYS_CALL

  ;; display sum
  push dword 1
  push dword res
  push dword STDOUT
  mov eax, 4
  sub esp, SYS_WRITE
  int SYS_CALL

  ;; newline
  push dword 1
  push dword nl
  push dword STDOUT
  mov eax, SYS_WRITE
  sub esp, 4
  int SYS_CALL

  ;; exit
  push dword 0
  mov eax, SYS_EXIT
  int SYS_CALL
