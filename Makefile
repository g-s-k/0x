UNAME := $(shell uname -s)

ifeq ($(UNAME),Darwin)
	LDFLAGS := -macosx_version_min 10.8
	LDLIBS := -lSystem
	NASMARCH := macho64
else
	LDFLAGS := -e _main
	NASMARCH := elf64
endif

BIN_DIR := ./bin
SRC_DIR := ./src

SRCS := $(wildcard $(SRC_DIR)/*.asm)
OUTS := $(basename $(SRCS))
BASE := $(notdir $(OUTS))

all: $(addprefix $(BIN_DIR)/, $(BASE))

$(BIN_DIR)/%: %.o $(BIN_DIR)
	$(LD) $(LDLIBS) $(LDFLAGS) -o $@ $<

%.o: $(SRC_DIR)/%.asm
	nasm -f $(NASMARCH) -o $@ $?

$(BIN_DIR):
	mkdir -p $@

.PHONY: clean run/%

run/%: $(BIN_DIR)/%
	$?

clean:
	$(RM) -r $(BIN_DIR)
