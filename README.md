# Groot
A command like tool to generate Tree representation from a given directory path

### Installation

Clone Groot on your machine:

```
$ git clone https://github.com/jjotaum/Groot.git
```
Navigate to it's directory:

```
$ cd Groot
```

Execute install script

Run install script using a directory as parameter e.g: /usr/local/bin

```
$ ./install.sh /usr/local/bin
```
Groot should now be installed on /usr/local/bin and can be accessed via terminal.
```
$ groot
```

### Usage

```
$ groot --help

USAGE: groot [--path <path>] [--depth <depth>] [--hidden <hidden>]

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
│   ├── Groot
│   │   ├── Groot.swift
│   │   ├── TreeGenerator.swift
│   │   └── main.swift
├── Tests
│   ├── GrootTests
│   │   └── GrootTests.swift
└── install.sh
```
