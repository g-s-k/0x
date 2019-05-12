BIN_DIR = ./bin
BUILD_DIR = ./build
SRC_DIR = ./src

SRCS = $(wildcard $(SRC_DIR)/*.asm)
OUTS = $(basename $(SRCS))
BASE = $(notdir $(OUTS))

all: $(BUILD_DIR) $(BIN_DIR) $(addprefix $(BIN_DIR)/, $(BASE))

$(BIN_DIR)/%: $(BUILD_DIR)/%.o
	$(LD) -lSystem -macosx_version_min 10.8 $(LDFLAGS) -o $@ $?

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm
	nasm -f macho64 -o $@ $?

$(BIN_DIR) $(BUILD_DIR):
	mkdir -p $@

.PHONY: clean run/%

run/%: $(BIN_DIR)/%
	$?

clean:
	$(RM) -r $(BIN_DIR) $(BUILD_DIR)
