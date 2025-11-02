<a id="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<br />
<div align="center">
  <h3 align="center">cman</h3>

  <p align="center">
    A modern C project manager and build orchestrator
    <br />
    <a href="https://github.com/jr-cho/cman"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/jr-cho/cman#quick-start">View Quick Start</a>
    &middot;
    <a href="https://github.com/jr-cho/cman/issues/new?labels=bug">Report Bug</a>
    &middot;
    <a href="https://github.com/jr-cho/cman/issues/new?labels=enhancement">Request Feature</a>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#quick-start">Quick Start</a></li>
    <li><a href="#project-types">Project Types</a></li>
    <li><a href="#commands">Commands</a></li>
    <li><a href="#configuration">Configuration</a></li>
    <li><a href="#usage">Usage Examples</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

## About The Project

cman is a modern C project manager inspired by Cargo. It provides a unified interface for creating, building, testing, and managing C projects with sensible defaults and minimal configuration overhead.

Why cman?
* Eliminates boilerplate no more copy and pasting Makefiles across projects
* Sensible conventions that work out of the box
* Unified workflow across standard, embedded, and minimal project types
* TOML based configuration that is straightforward and readable

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

* Bash/Shell scripting
* TOML configuration format
* GCC and Clang C compilers
* ARM embedded GCC toolchain
* clang-format for code formatting
* clang-tidy for static analysis

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started

This section provides instructions for setting up cman on your local system.

### Prerequisites

Required:
* A C compiler: `clang`, `gcc`, or compatible alternative
* For embedded projects: `arm-none-eabi-gcc`

Optional:
* `clang-format` - Code formatting integration
* `clang-tidy` - Static analysis integration

### Installation

1. Clone the repository
   ```sh
   git clone https://github.com/jr-cho/cman.git
   cd cman
   ```

2. Make the script executable
   ```sh
   chmod +x cman
   ```

3. (Optional) Install system-wide
   ```sh
   sudo cp cman /usr/local/bin/
   ```

Verify installation:
   ```sh
   cman version
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Quick Start

### Create a new project

Standard project with modular structure:
```sh
cman new my_app
cd my_app
cman build
cman run
```

Minimal project for simple applications:
```sh
cman new my_tool --clean
cd my_tool
cman build
```

Embedded firmware project:
```sh
cman new my_firmware --embedded
cd my_firmware
cman build
```

### Initialize an existing project

Convert an existing C project to use cman:
```sh
cd my_existing_project
cman init              # Default type
cman init --clean      # Minimal type
cman init --embedded   # Embedded type
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Project Types

### Default
Full-featured project template with modular structure.

```
my_app/
├── include/        # Header files
├── src/            # Source files (auto-discovered)
├── build/          # Build artifacts (generated)
├── bin/            # Compiled binaries (generated)
├── cman.toml       # Project configuration
├── README.md       # Documentation
└── .gitignore
```

**Suitable for:** Production applications, libraries, and complex projects

### Clean
Minimal project template with essential files only.

```
my_tool/
├── src/            # Source files only
├── build/          # Build artifacts (generated)
├── bin/            # Compiled binaries (generated)
├── cman.toml       # Project configuration
├── README.md
└── .gitignore
```

**Suitable for:** Utilities, prototypes, and simple applications

### Embedded
Bare-metal embedded systems template with cross-compilation support.

```
my_firmware/
├── include/        # Hardware definitions and headers
├── src/            # Firmware source code
├── build/          # Build artifacts (generated)
├── bin/            # Firmware binaries (generated)
├── cman.toml       # Embedded-specific configuration
├── README.md
└── .gitignore
```

**Suitable for:** Microcontroller firmware and embedded development

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Commands

### Project Management
```sh
cman new <n> [--clean | --embedded]    Create new project
cman init [--clean | --embedded]          Initialize current directory as project
```

### Building
```sh
cman build [--release]                    Compile project (debug by default)
cman run [args...]                        Execute compiled binary
cman clean                                Remove build artifacts
```

### Development
```sh
cman test                                 Compile and run tests
cman format                               Format code with clang-format
cman check                                Run static analysis with clang-tidy
```

### Configuration
```sh
cman config view                          Display project configuration
cman config get <key>                     Retrieve specific configuration value
cman config set <key> <value>             Update configuration value
cman env                                  Display environment information
```

### Information
```sh
cman help                                 Display usage information
cman man                                  Display manual page
cman version                              Display version number
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Configuration

Projects are configured via `cman.toml` in TOML format:

```toml
[project]
name = "my_app"
version = "0.1.0"
type = "default"

[build]
compiler = "clang"
src = "src"
include = "include"
build = "build"
bin = "bin"
cflags = "-Wall -Wextra -std=c11"
ldflags = ""

[dev]
debug = true
optimization = "0"

[release]
debug = false
optimization = "3"
```

### Common Configuration Changes

Use GCC instead of Clang:
```sh
cman config set build_compiler gcc
```

Add compiler flags:
```sh
cman config set build_cflags "-Wall -Wextra -std=c11 -fsanitize=address"
```

Link against libraries:
```sh
cman config set build_ldflags "-lm -lpthread"
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage

### Standard Workflow

Build in debug mode:
```sh
cman build
cman run
```

Build optimized release version:
```sh
cman build --release
./bin/my_app
```

### Working with Source Files

Add new source files to `src/` and headers to `include/`. cman automatically discovers and compiles all `.c` files:

```sh
# Create new files
echo '#include "util.h"' > src/util.c
echo '#pragma once' > include/util.h

# Rebuild automatically finds new files
cman build
```

### Testing

Run all tests in the `tests/` directory:
```sh
cman test
```

### Code Quality

Format all source files:
```sh
cman format
```

Run static analysis:
```sh
cman check
```

### Embedded Development

Configure for specific embedded target:
```sh
cman new stm32_project --embedded
cd stm32_project

cman config set build_compiler arm-none-eabi-gcc
cman config set build_cflags "-Wall -Wextra -mcpu=cortex-m3 -mthumb -nostdlib"
cman build
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Roadmap

**Completed**
- [x] Project scaffolding with multiple templates
- [x] Multi-project type support (default, clean, embedded)
- [x] Configuration management
- [x] Build system with compiler abstraction
- [x] Code formatting integration
- [x] Static analysis integration

**Planned**
- [ ] Dependency management
- [ ] Package and distribution support
- [ ] System-wide package installation
- [ ] Performance profiling and benchmarking
- [ ] Custom linker script support
- [ ] Additional cross-compilation targets

See the [open issues](https://github.com/jr-cho/cman/issues) for a detailed list of proposed features and known issues.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contributing

Contributions are welcome and greatly appreciated. They help make the open source community an excellent place to learn, inspire, and create.

To contribute:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

If you have a suggestion that would improve cman, please fork the repository and create a pull request, or open an issue with the "enhancement" label.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact

jr-cho - [@jr_cho_](https://twitter.com/jr_cho_)

Project Link: [https://github.com/jr-cho/cman](https://github.com/jr-cho/cman)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/jr-cho/cman.svg?style=for-the-badge
[contributors-url]: https://github.com/jr-cho/cman/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/jr-cho/cman.svg?style=for-the-badge
[forks-url]: https://github.com/jr-cho/cman/network/members
[stars-shield]: https://img.shields.io/github/stars/jr-cho/cman.svg?style=for-the-badge
[stars-url]: https://github.com/jr-cho/cman/stargazers
[issues-shield]: https://img.shields.io/github/issues/jr-cho/cman.svg?style=for-the-badge
[issues-url]: https://github.com/jr-cho/cman/issues
[license-shield]: https://img.shields.io/github/license/jr-cho/cman.svg?style=for-the-badge
[license-url]: https://github.com/jr-cho/cman/LICENSE
