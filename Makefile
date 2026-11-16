# --- Variables ---
BOARD = arduino:megaavr:nona4809
BUILD_DIR = build

# --- Dynamic Port Detection ---
# This runs a shell command to list boards, looks for your FQBN, and pulls the port path (e.g., /dev/ttyACM1)
PORT = $(shell arduino-cli board list | grep '$(BOARD)' | awk '{print $$1}')

# --- Targets ---

# Default target: compile and upload together
all: compile upload

# 1. Compile the sketch
compile:
	arduino-cli compile --fqbn $(BOARD) --build-path $(BUILD_DIR)

# 2. Upload the compiled binary
upload:
	@if [ -z "$(PORT)" ]; then \
		echo "ERROR: No connected board found matching $(BOARD)"; \
		exit 1; \
	fi
	arduino-cli upload -p $(PORT) --fqbn $(BOARD) --input-dir $(BUILD_DIR)

# 3. Open the serial monitor
monitor:
	@if [ -z "$(PORT)" ]; then \
		echo "ERROR: No connected board found matching $(BOARD)"; \
		exit 1; \
	fi
	arduino-cli monitor -p $(PORT) --config baudrate=9600

# Helper target to check what port was detected
check-port:
	@if [ -z "$(PORT)" ]; then \
		echo "No matching board connected."; \
	else \
		echo "Detected board on port: $(PORT)"; \
	fi

.PHONY: all compile upload monitor check-port
