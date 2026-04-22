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

USAGE: ceroxylon [--path <path>] [--depth <depth>] [--hidden] [--pretty] [--summary]

OPTIONS:
  -p, --path <path>       The directory path
  -d, --depth <depth>     The depth of the generated tree (default: 100)
      --hidden            Includes hidden files in the generated tree.
      --pretty            Adds icons for directories and known package, archive, settings, code, text, image, and video files, plus a fallback for unmatched files.
      --summary           Appends a summary of directories and files to the output.
  -h, --help              Show help information.

```

By default, Ceroxylon uses the current working directory when `--path` is not provided. Add `--summary` to include a footer with the number of directories and files.

When `--pretty` is enabled, Ceroxylon marks common package and archive files with `📦`. Supported extensions are:
`.7z`, `.apk`, `.crate`, `.deb`, `.dmg`, `.gem`, `.ipa`, `.jar`, `.msi`, `.pkg`, `.rar`, `.rpm`, `.tar`, `.tar.bz2`, `.tar.gz`, `.tar.xz`, `.tbz2`, `.tgz`, `.txz`, `.whl`, `.zip`.

It also marks common code files with `💻`. Supported extensions are:
`.c`, `.cc`, `.cpp`, `.cs`, `.css`, `.go`, `.h`, `.hpp`, `.html`, `.java`, `.js`, `.json`, `.kt`, `.m`, `.php`, `.pl`, `.py`, `.rb`, `.rs`, `.sh`, `.sql`, `.swift`, `.ts`, `.tsx`, `.xml`.

Settings files are marked with `⚙️`. Supported extensions are:
`.cfg`, `.cnf`, `.conf`, `.config`, `.env`, `.ini`, `.plist`, `.properties`, `.service`, `.toml`, `.yaml`, `.yml`.
Common settings filenames are also matched:
`.editorconfig`, `.env.example`, `.gitconfig`, `.gitignore`, `.npmrc`, `.prettierrc`, `.tool-versions`, `Cargo.toml`, `Package.swift`, `composer.json`, `deno.json`, `deno.jsonc`, `package.json`, `tsconfig.json`.

Text documents are marked with `🗒️`. Supported extensions are:
`.csv`, `.log`, `.md`, `.rst`, `.rtf`, `.text`, `.txt`.

Directories are marked with `📁` in pretty mode.

Image files are marked with `🖼️`. Supported extensions are:
`.avif`, `.bmp`, `.gif`, `.heic`, `.jpeg`, `.jpg`, `.png`, `.svg`, `.tiff`, `.webp`.

Video files are marked with `🎬`. Supported extensions are:
`.avi`, `.m4v`, `.mkv`, `.mov`, `.mp4`, `.mpeg`, `.mpg`, `.webm`.

Unmatched files are marked with `📄`.

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

With pretty mode enabled:

```
$ ceroxylon --pretty
```

```
├── 📦 Ceroxylon.pkg
├── 🖼️ logo.png
├── 🗒️ README.md
├── ⚙️ .editorconfig
├── 📄 blob.dat
├── 🎬 trailer.mp4
└── 📁 releases/
    └── 📦 Ceroxylon.tar.gz
```
