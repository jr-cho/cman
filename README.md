# CMAN: A Lightweight C Project Manager

`cman` is a shell-based tool to simplify the setup, build, run, and clean process for C projects. It provides a minimalistic workflow to help developers focus on programming rather than on repetitive tasks like folder creation or compilation commands.

---

## Introduction

C development often requires setting up the same folder structure, writing Makefiles, and remembering long compiler flags. `cman` was created to streamline this process.

With `cman`, you can:

* Quickly scaffold new C projects with a consistent folder layout
* Compile all source files using a single command
* Run and clean projects without extra configuration
* Maintain your workflow using a global alias like `b`

This tool is ideal for personal projects, learning exercises, or quick prototyping in C.

---

## User Instructions

### Requirements

* Bash (tested with GNU Bash 5.x+)
* GCC (or a compatible C compiler)

---

### Setup

1. **Clone or download** `cman.sh` and `cman_env` to your project or scripts folder.

2. **Make the script executable**:

   ```bash
   chmod +x cman.sh
   ```

3. **Activate the alias**

   You can either:

   * Source it manually each time:

     ```bash
     source ./cman_env
     ```
   * Or, permanently add it to your shell config:

     **For Bash:**

     ```bash
     echo "source /path/to/cman_env" >> ~/.bashrc
     source ~/.bashrc
     ```

     **For Zsh:**

     ```bash
     echo "source /path/to/cman_env" >> ~/.zshrc
     source ~/.zshrc
     ```

---

### Usage

Once set up, you can run the tool using the alias `b` or directly via `./cman.sh`:

```bash
b init      # Set up folders and README
b build     # Compile .c files into build/
b run       # Execute the compiled binary
b clean     # Remove build/ and bin/
```

#### Folder structure after `init`:

```
.
├── src/         # Source files (e.g. main.c)
├── include/     # Header files
├── docs/        # Project documentation
├── build/       # Compiled binaries
├── bin/         # Optional binaries/scripts
├── cman.sh      # The main script
├── cman_env     # Optional environment/alias script
└── README.md
```

---

## Contributor Instructions

If you’d like to contribute:

1. Fork the repository or copy the script into your own workspace.
2. Extend the command parser inside `cman.sh` with new features (e.g. debug flags, header dependency scanning, test automation).
3. Test your changes in a temporary C project using the provided command structure.
4. Share your improvements or submit pull requests if this is hosted on GitHub.

Suggested enhancements:

* Makefile integration
* Multiple binary outputs
* Basic unit test runner
* Cross-platform support

