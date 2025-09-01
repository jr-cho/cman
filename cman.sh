#!/usr/bin/env bash

#
#        ██╗██████╗        ██████╗██╗  ██╗ ██████╗
#        ██║██╔══██╗      ██╔════╝██║  ██║██╔═══██╗
#        ██║██████╔╝█████╗██║     ███████║██║   ██║
#   ██   ██║██╔══██╗╚════╝██║     ██╔══██║██║   ██║
#   ╚█████╔╝██║  ██║      ╚██████╗██║  ██║╚██████╔╝
#    ╚════╝ ╚═╝  ╚═╝       ╚═════╝╚═╝  ╚═╝ ╚═════╝
#

VERSION="1.0.3"
BUILD_DIR="build"
SRC_DIR="src"
TEST_DIR="tests"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

create_makefile() {
    local name="$1"

    cat > "Makefile" << EOF
CC = clang
CFLAGS = -Wall -Wextra -std=c99 -g
TARGET = $name
BUILD_DIR = $BUILD_DIR
SRC_DIR = $SRC_DIR
TEST_DIR = $TEST_DIR

SOURCES = \$(wildcard \$(SRC_DIR)/*.c)
TEST_SOURCES = \$(wildcard \$(TEST_DIR)/*.c)

.PHONY: all build run clean test-build test-run test-clean

all: build

\$(BUILD_DIR)/\$(TARGET): \$(SOURCES)
	@mkdir -p \$(BUILD_DIR)
	@echo "[BUILD] Compiling..."
	\$(CC) \$(CFLAGS) \$(SOURCES) -o \$@
	@echo "[✓] Build completed"

build: \$(BUILD_DIR)/\$(TARGET)

run: build
	@echo "[RUN] Executing \$(TARGET)..."
	@./\$(BUILD_DIR)/\$(TARGET)

test-build: \$(TEST_SOURCES)
	@mkdir -p \$(BUILD_DIR)
	@echo "[BUILD] Compiling tests..."
	\$(CC) \$(CFLAGS) \$(TEST_SOURCES) -o \$(BUILD_DIR)/test_runner
	@echo "[✓] Tests built"

test-run: test-build
	@echo "[TEST] Running tests..."
	@./\$(BUILD_DIR)/test_runner

test-clean:
	@echo "[CLEAN] Removing test artifacts..."
	@rm -f \$(BUILD_DIR)/test_runner
	@echo "[✓] Test clean completed"

clean:
	@echo "[CLEAN] Removing build artifacts..."
	@rm -rf \$(BUILD_DIR)
	@echo "[✓] Clean completed"
EOF
}

cmd_new() {
    local name="$1"

    if [[ -z "$name" ]]; then
        log_error "Project name required"
        echo "Usage: cman new <name>"
        exit 1
    fi

    if [[ -d "$name" ]]; then
        log_error "Directory '$name' already exists"
        exit 1
    fi

    log_info "Creating project '$name'"

    mkdir -p "$name/$SRC_DIR"

    cd "$name"

    create_makefile "$name"

    cat > "$SRC_DIR/main.c" << EOF
#include <stdio.h>

int main(void) {
    printf("Hello from $name!\\n");
    return 0;
}
EOF

    cat > "README.md" << EOF
# $name

## Usage

\`\`\`bash
cman build       # Build
cman run         # Run
cman test init   # Create tests
cman test build  # Build tests
cman test run    # Run tests
\`\`\`
EOF

    if command -v git > /dev/null 2>&1; then
        git init > /dev/null 2>&1
        echo "$BUILD_DIR/" > .gitignore
    fi

    log_success "Created project '$name'"
    echo ""
    echo "Next steps:"
    echo "  cd $name"
    echo "  cman build"
    echo "  cman run"
}

cmd_init() {
    local name="${1:-$(basename "$(pwd)")}"

    if [[ -f "Makefile" ]]; then
        log_error "Makefile already exists"
        exit 1
    fi

    log_info "Initializing project '$name'"

    mkdir -p "$SRC_DIR"

    create_makefile "$name"

    if [[ ! -f "$SRC_DIR/main.c" ]]; then
        cat > "$SRC_DIR/main.c" << EOF
#include <stdio.h>

int main(void) {
    printf("Hello, World!\\n");
    return 0;
}
EOF
    fi

    log_success "Initialized project '$name'"
}

cmd_build() {
    if [[ ! -f "Makefile" ]]; then
        log_error "Not a cman project. Run 'cman init' first."
        exit 1
    fi

    make build
}

cmd_run() {
    if [[ ! -f "Makefile" ]]; then
        log_error "Not a cman project. Run 'cman init' first."
        exit 1
    fi

    make run
}

cmd_test() {
    local action="$1"
    shift

    case "$action" in
        init)
            mkdir -p "$TEST_DIR"
            if [[ ! -f "$TEST_DIR/test.c" ]]; then
                cat > "$TEST_DIR/test.c" << EOF
#include <stdio.h>
#include <assert.h>

int main(void) {
    printf("Running tests...\\n");
    assert(1 == 1);
    printf("All tests passed!\\n");
    return 0;
}
EOF
                log_success "Created test template in $TEST_DIR/test.c"
            else
                log_info "Test directory already initialized"
            fi
            ;;
        build)
            make test-build
            ;;
        run)
            make test-run
            ;;
        clean)
            make test-clean
            ;;
        *)
            echo "Usage: cman test {init|build|run|clean}"
            ;;
    esac
}

cmd_clean() {
    if [[ ! -f "Makefile" ]]; then
        log_error "Not a cman project"
        exit 1
    fi

    make clean
}

print_usage() {
    echo -e "${BLUE}"
    cat << "EOF"
        ██████╗███╗   ███╗ █████╗ ███╗   ██╗
       ██╔════╝████╗ ████║██╔══██╗████╗  ██║
       ██║     ██╔████╔██║███████║██╔██╗ ██║
       ██║     ██║╚██╔╝██║██╔══██║██║╚██╗██║
       ╚██████╗██║ ╚═╝ ██║██║  ██║██║ ╚████║
        ╚═════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
EOF
    echo -e "${NC}"
    echo -e "${BLUE}        Lightweight C Manager v$VERSION${NC}"
    echo ""
    cat << EOF
USAGE:
    cman <command> [options]

COMMANDS:
    new <name>        Create new C project
    init [name]       Initialize current directory
    build             Build with clang
    run               Build and run
    test <subcmd>     Manage tests
    clean             Clean build artifacts
    help              Show this help

TEST SUBCOMMANDS:
    test init         Create test directory and starter file
    test build        Build tests
    test run          Run tests
    test clean        Remove test build artifacts

EXAMPLES:
    cman new my_app
    cd my_app
    cman build && cman run
    cman test init
    cman test build && cman test run
EOF
}

cmd_version() {
    echo -e "${BLUE}"
    cat << "EOF"
        ██████╗███╗   ███╗ █████╗ ███╗   ██╗
       ██╔════╝████╗ ████║██╔══██╗████╗  ██║
       ██║     ██╔████╔██║███████║██╔██╗ ██║
       ██║     ██║╚██╔╝██║██╔══██║██║╚██╗██║
       ╚██████╗██║ ╚═╝ ██║██║  ██║██║ ╚████║
        ╚═════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
EOF
    echo -e "${NC}"
    echo -e "${BLUE}        Lightweight C Manager v$VERSION${NC}"
    echo ""
    echo "Dead simple C project management."
    echo "Build • Run • Test"
}

main() {
    local command="$1"
    shift

    case "$command" in
        new)
            cmd_new "$@"
            ;;
        init)
            cmd_init "$@"
            ;;
        build|b)
            cmd_build "$@"
            ;;
        run|r)
            cmd_run "$@"
            ;;
        test)
            cmd_test "$@"
            ;;
        clean|c)
            cmd_clean "$@"
            ;;
        version|--version)
            cmd_version
            ;;
        help|--help|"")
            print_usage
            ;;
        *)
            log_error "Unknown command '$command'"
            echo "Run 'cman help' for usage"
            exit 1
            ;;
    esac
}

main "$@"

