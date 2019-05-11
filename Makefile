SRCS = $(wildcard src/*.asm)
OUTS = $(basename $(SRCS))
BASE = $(notdir $(OUTS))

.PHONY = run/%

all: bin $(addprefix bin/, $(BASE))

run/%: bin/%
	$?

bin:
	mkdir bin

bin/%: %.o
	ld -lSystem -macosx_version_min 10.8 -o $@ $?

%.o: src/%.asm
	nasm -f macho64 -o $@ $?
