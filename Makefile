%: %.o
	ld -e _start -lSystem -macosx_version_min 10.8 -o $@ $?

%.o: %.asm
	nasm -f macho -o $@ $?
