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

USAGE: ceroxylon [--path <path>] [--depth <depth>] [--hidden] [--summary]

OPTIONS:
  -p, --path <path>       The directory path
  -d, --depth <depth>     The depth of the generated tree (default: 100)
      --hidden            Includes hidden files in the generated tree.
      --summary           Appends a summary of directories and files to the generated Markdown.
  -h, --help              Show help information.

```

By default, Ceroxylon uses the current working directory when `--path` is not provided. Add `--summary` to include a footer with the number of directories and files inside the generated Markdown block.

### Output Example

```
$ ceroxylon --summary
```

Directories are suffixed with `/` to make the tree easier to scan.

```
├── LICENSE
├── Package.resolved
├── Package.swift
├── README.md
├── Sources/
│   └── Ceroxylon/
│       ├── Ceroxylon.swift
│       ├── TreeGenerator.swift
│       └── main.swift
├── Tests/
│   └── CeroxylonTests/
│       └── CeroxylonTests.swift
└── install.sh

3 directories, 8 files
```
