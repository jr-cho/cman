#!/usr/bin/env bash

# Script: cman.sh
# Description: Lightweight C Manager 
# Version: 1.0.0
# Usage: ./cman.sh [options | --init, -i, --build, -b, --run, -r, --clean, -c]

# 
#        ██╗██████╗        ██████╗██╗  ██╗ ██████╗     
#        ██║██╔══██╗      ██╔════╝██║  ██║██╔═══██╗    
#        ██║██████╔╝█████╗██║     ███████║██║   ██║    
#   ██   ██║██╔══██╗╚════╝██║     ██╔══██║██║   ██║    
#   ╚█████╔╝██║  ██║      ╚██████╗██║  ██║╚██████╔╝    
#    ╚════╝ ╚═╝  ╚═╝       ╚═════╝╚═╝  ╚═╝ ╚═════╝     
#                                                 

# Configuration
PROJECT_NAME="app"
SRC_DIR="src"
INCLUDE_DIR="include"
DOCS_DIR="docs"
BUILD_DIR="build"
BIN_DIR="bin"

# Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

# Initializing C Project Helper Function
function init_project() {
  echo -e "${GREEN}Initializing C project structure...${NC}"
  mkdir -p "$SRC_DIR" "$INCLUDE_DIR" "$DOCS_DIR" "$BUILD_DIR" "$BIN_DIR"

  touch "$SRC_DIR/main.c"
  echo "// main.c - entry point" > "$SRC_DIR/main.c"

  echo "# $PROJECT_NAME" > README.md
  echo "Project initialized with folders: src/, include/, docs/, build/, bin/" >> README.md

  echo -e "${GREEN}Done.${NC}"
}

# Build Helper Function
function build_project() {
  echo -e "${GREEN}Building project...${NC}"
  mkdir -p "$BUILD_DIR"

  gcc "$SRC_DIR"/*.c -I"$INCLUDE_DIR" -o "$BUILD_DIR/$PROJECT_NAME"
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}Build succeeded. Output: $BUILD_DIR/$PROJECT_NAME${NC}"
  else
    echo -e "${RED}Build failed.${NC}"
  fi
}

# Run Helper Function
function run_project() {
  BIN="$BUILD_DIR/$PROJECT_NAME"
  if [ -f "$BIN" ]; then
    echo -e "${GREEN}Running $BIN...${NC}"
    "$BIN"
  else
    echo -e "${RED}Build output not found. Run './cman.sh build' first.${NC}"
  fi
}

# Clean Healper Function
function clean_project() {
  echo -e "${RED}Cleaning build and bin directories...${NC}"
  rm -rf "$BUILD_DIR" "$BIN_DIR"
  echo -e "${GREEN}Cleaned.${NC}"
}

# Command handler
case "$1" in
  --init|-i)
    init_project
    ;;
  --build|-b)
    build_project
    ;;
  --run|-r)
    run_project
    ;;
  --clean|-c)
    clean_project
    ;;
  *)
    echo -e "${RED}Usage:${NC} ./cman.sh [options | --init, -i, --build, -b, --run, -r, --clean, -c]"
    ;;
esac
