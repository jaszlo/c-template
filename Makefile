# Compiler and flags
CC := gcc
CFLAGS := -Wall -Wextra -std=c11 -g

# Directories
SRC_DIR := src
BUILD_DIR := build

# Find all source files recursively in src directory
SRCS := $(shell find $(SRC_DIR) -type f -name '*.c')

# Create a list of object files based on source file locations
OBJS := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

# Main source file
MAIN_SRC := src/test/main.c

# Target executable
TARGET := main

all: clean set_prod $(BUILD_DIR) $(TARGET)
debug: clean set_debug $(BUILD_DIR) $(TARGET)

set_prod:
	$(eval OPTIMIZATION_FLAGS := -O3)


valgrind: clean set_debug $(BUILD_DIR) $(TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET)

set_debug:
	$(eval DEBUG_FLAGS := -D GDB -O0)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(DEBUG_FLAGS) $(OPTIMIZATION_FLAGS) -c $< -o $@

# Compile the main source file
$(BUILD_DIR)/main.o: $(MAIN_SRC)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(DEBUG_FLAGS) $(OPTIMIZATION_FLAGS) -c $< -o $@

# Link all object files to create the final executable
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

clean:
	rm -rf $(BUILD_DIR) $(TARGET)

.PHONY: all clean

run:
	./$(TARGET)

gdb:
	gdb ./$(TARGET) --command=.gdb_init --args $(TARGET) array



.PHONY: all clean run
