SRCS = $(wildcard src/*.asm)
OUTS = $(basename $(SRCS))
BASE = $(notdir $(OUTS))

all: bin $(addprefix bin/, $(BASE))

bin:
	mkdir bin

bin/%: %.o
	ld -e _start -lSystem -macosx_version_min 10.8 -o $@ $?

%.o: src/%.asm
	nasm -f macho -o $@ $?
