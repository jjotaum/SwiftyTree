# Ceroxylon
A command-line tool that generates a tree representation of a directory.

### Why the name? 🌴

Ceroxylon is inspired by *Ceroxylon quindiuense*, the Quindio wax palm, which is recognized as the national tree of Colombia. You can read more about it on [Wikipedia](https://en.wikipedia.org/wiki/Ceroxylon_quindiuense).

### Installation

Clone Ceroxylon to your machine:

```
$ git clone https://github.com/jjotaum/Ceroxylon.git
```
Navigate to its directory:

```
$ cd Ceroxylon
```

Run the install script.

Pass the destination directory as an argument, for example `/usr/local/bin`:

```
$ ./install.sh /usr/local/bin
```
Ceroxylon should now be installed in `/usr/local/bin` and available from your terminal:
```
$ ceroxylon
$ xylon
```

### Usage

```
$ ceroxylon --help

USAGE: ceroxylon [--path <path>] [--depth <depth>] [--hidden]

OPTIONS:
  -p, --path <path>       The directory path
  -d, --depth <depth>     The depth of the generated tree (default: 100)
      --hidden            Includes hidden files in the generated tree.
  -h, --help              Show help information.

```

By default, Ceroxylon uses the current working directory when `--path` is not provided.

### Output Example

```
├── LICENSE
├── Package.resolved
├── Package.swift
├── README.md
├── Sources
│   └── Ceroxylon
│       ├── Ceroxylon.swift
│       ├── TreeGenerator.swift
│       └── main.swift
├── Tests
│   └── CeroxylonTests
│       └── CeroxylonTests.swift
└── install.sh
```
