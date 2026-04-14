# Ceroxylon
A command like tool to generate Tree representation from a given directory path

### Why the name? 🌴

Ceroxylon is inspired by *Ceroxylon quindiuense*, the Quindio wax palm, which is recognized as the national tree of Colombia. You can read more about it on [Wikipedia](https://en.wikipedia.org/wiki/Ceroxylon_quindiuense).

### Installation

Clone Ceroxylon on your machine:

```
$ git clone https://github.com/jjotaum/Ceroxylon.git
```
Navigate to it's directory:

```
$ cd Ceroxylon
```

Execute install script

Run install script using a directory as parameter e.g: /usr/local/bin

```
$ ./install.sh /usr/local/bin
```
Ceroxylon should now be installed on /usr/local/bin and can be accessed via terminal.
```
$ ceroxylon
```

### Usage

```
$ ceroxylon --help

USAGE: ceroxylon [--path <path>] [--depth <depth>] [--hidden <hidden>]

OPTIONS:
  -p, --path <path>       The directory path
  -d, --depth <depth>     The depth of the generated tree (default: 100)
  -h, --hidden <hidden>   Defines if generated tree includes hidden files. (default: false)
  -h, --help              Show help information.

```

### Output Example

```
├── LICENSE
├── Package.resolved
├── Package.swift
├── README.md
├── Sources
│   ├── Ceroxylon
│   │   ├── Ceroxylon.swift
│   │   ├── TreeGenerator.swift
│   │   └── main.swift
├── Tests
│   ├── CeroxylonTests
│   │   └── CeroxylonTests.swift
└── install.sh
```
