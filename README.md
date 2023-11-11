# SwiftyTree
A command like tool to generate Tree representation from a given directory path

### Installation

Clone SwiftyTree on your machine:

```
$ git clone https://github.com/jjotaum/SwiftyTree.git
```
Navigate to it's directory:

```
$ cd SwiftyTree
```

Execute install script
```
$ ./install.sh
```
SwiftyTree should now be installed on /usr/local/bin and can be accessed via terminal.
```
$ swifty-tree
```

### Usage

```
$ swifty-tree --help

USAGE: swifty-tree [--path <path>] [--depth <depth>] [--hidden <hidden>]

OPTIONS:
  -p, --path <path>       The directory path
  -d, --depth <depth>     The depth of the generated tree (default: 100)
  -h, --hidden <hidden>   Defines if generated tree includes hidden files.
                          (default: false)
  -h, --help              Show help information.
```

### Output Example

```
├── LICENSE
├── install.sh
├── Tests
│   ├── SwiftyTreeTests
│   │   └── SwiftyTreeTests.swift
├── README.md
├── Package.resolved
├── Package.swift
├── Sources
│   ├── SwiftyTree
│   │   ├── TreeGenerator.swift
│   │   ├── SwiftyTree.swift
│   │   └── main.swift
```
