section	.text
   global _start

_start:
  ;; print original form
  push dword 9
  push dword name
  push dword 1
  mov	eax, 4
  sub esp, 4
  int	0x80

  ;; change the first four chars
  mov	[name],  dword "Nuha"

  ;; print it again
  push dword 8                  ; no trailing space
  push dword name
  push dword 1
  mov	eax, 4
  sub esp, 4
  int	0x80

  ;; newline
  push dword 1
  push dword nl
  push dword 1
  mov	eax, 4
  sub esp, 4
  int	0x80

  ;; exit
  mov	eax, 1
  sub esp, 4
  int	0x80

section	.data
  name db "Zara Ali "
  nl db "", 0xa
