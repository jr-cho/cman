# CMAN: A Lightweight C Manager

## Introduction

`cman` simplifies the way you start, build, run, and maintain C projects by eliminating setup friction and repetitive typing. Inspired by personal need and cargo, this tool was built to make project creation and management quicker, cleaner, and more fun.

### Why CMAN?

* Automatically scaffold a standardized folder structure
* Compile all source files into a build directory
* Clean build files with one command
* Run output binaries instantly
* All via short aliases

## Features

* `init` – Setup new project folder layout
* `build` – Compile source files
* `run` – Run the compiled binary
* `clean` – Clean compiled binaries and build folders

## Setup

### Requirements

* Bash (tested with GNU Bash 5.x+)
* GCC compiler

### Installation

1. Download `cman.sh` and `cman_env` to your project folder.

2. Make the script executable:

```bash
chmod +x cman.sh
```

3. Activate the environment:

```bash
source ./cman_env
```

Or permanently add the alias to your shell:

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

### Optional: Inherit environment across subdirectories

If you want all child folders inside your main `C` folder to automatically inherit the `cman_env`, consider using [`direnv`](https://direnv.net/).

1. Install `direnv` (if not already installed):

```bash
# On most systems
brew install direnv   # macOS
sudo apt install direnv   # Debian/Ubuntu
```

2. Hook `direnv` into your shell:

**For Bash:**

```bash
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
source ~/.bashrc
```

**For Zsh:**

```bash
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
source ~/.zshrc
```

3. In your `~/C` folder, create a `.envrc` file with:

```bash
source ~/C/cman_env
```

4. Approve the file:

```bash
direnv allow
```

Now, every time you `cd` into your C folder or one of its subfolders, `cman_env` will be automatically loaded.

## Usage

Once set up, you can run the tool using the alias `b` or directly via `./cman.sh`:

```bash
i     # Set up folders and README
b     # Compile .c files into build/
r     # Execute the compiled binary
c     # Remove build/ and bin/
```

### Folder Structure

```
.
├── src/         # Source files
├── include/     # Header files
├── docs/        # Documentation
├── build/       # Compiled outputs
├── bin/         # Optional executable location
├── cman.sh      # Script file
├── cman_env     # Environment alias file
└── README.md
```

## Contributing

We welcome all contributions! Here’s how to get started:

1. Fork or clone the repo
2. Improve or add features (e.g., Makefile support, testing)
3. Test your changes in a sample project
4. Submit a pull request (PR)

Some Ideas I had:

* Makefile generation
* Multiple binary support
* Built-in test runner

## License

This project is open-source and licensed under the [MIT License](./LICENSE).

