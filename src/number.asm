section .data
  userMsg db "Please enter a number: "
  lenUserMsg equ $-userMsg
  dispMsg db "You entered the number "
  lenDispMsg equ $-dispMsg

section .bss
  num resb 5

section .text
  global _start

_start:
  ;; prompt for number
  push dword lenUserMsg
  push dword userMsg
  push dword 1
  mov eax, 4
  sub esp, 4
  int 0x80

  ;; read input
  push dword 5
  push dword num
  push dword 2
  mov eax, 3
  sub esp, 4
  int 0x80

  ;; show text before result
  push dword lenDispMsg
  push dword dispMsg
  push dword 1
  mov eax, 4
  sub esp, 4
  int 0x80

  ;; display result
  push dword 5
  push dword num
  push dword 1
  mov eax, 4
  sub esp, 4
  int 0x80

  ;; exit
  mov eax, 1
  mov ebx, 0
  sub esp, 4
  int 0x80
