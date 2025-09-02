# CMAN – Lightweight C Manager

**CMAN** is a lightweight project manager for **C development with Clang**, inspired by Cargo (Rust’s package manager).
It makes it easy to create, build, run, and test C projects without writing manual Makefiles.

---

## Features

* Initialize new or existing C projects
* Auto-generate **Makefile** with sensible defaults (Clang, `-Wall -Wextra -std=c99`)
* Simple commands to **build** and **run** projects
* Built-in test system (`cman test`)
* Clean up build artifacts
* Git integration out-of-the-box (adds `.gitignore` for build dir)

---

## Installation

Clone the repo and put `cman` in your `$PATH`:

```bash
git clone https://github.com/jr-cho/cman.git
cd cman
chmod +x cman
sudo cp cman /usr/local/bin/cman
```

Verify installation:

```bash
cman version
```

---

## Usage

```bash
cman <command> [options]
```

### Commands

| Command              | Description                                      |
| -------------------- | ------------------------------------------------ |
| `cman new <name>`    | Create a new C project with default structure    |
| `cman init [name]`   | Initialize C project in current directory        |
| `cman build`         | Compile source files into the `build/` directory |
| `cman run`           | Build and run the program                        |
| `cman test <subcmd>` | Manage tests (`init`, `build`, `run`, `clean`)   |
| `cman clean`         | Remove build artifacts                           |
| `cman help`          | Show help message                                |
| `cman version`       | Show CMAN version                                |

---

## Test Subcommands

| Subcommand        | Description                               |
| ----------------- | ----------------------------------------- |
| `cman test init`  | Create a `tests/` directory with template |
| `cman test build` | Compile tests into `build/test_runner`    |
| `cman test run`   | Execute tests                             |
| `cman test clean` | Remove test artifacts                     |

---

## Examples

Create a new project:

```bash
cman new hello_c
cd hello_c
cman build
cman run
```

Add a test suite:

```bash
cman test init
cman test build
cman test run
```

Clean up:

```bash
cman clean
```

---

## Project Structure

When you create a project with `cman new my_app`, you get:

```
my_app/
├── src/
│   └── main.c
├── tests/          # (optional, created with `cman test init`)
├── build/          # (generated on build)
├── Makefile
└── README.md
```

---

## License

MIT License.
