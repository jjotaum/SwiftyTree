import XCTest
@testable import Ceroxylon

final class CeroxylonTests: XCTestCase {
    func testGeneratesProperConnectorsForNestedDirectories() throws {
        let root = try makeTemporaryDirectory()
        let alpha = root.appendingPathComponent("alpha", isDirectory: true)
        let beta = root.appendingPathComponent("beta", isDirectory: true)
        try FileManager.default.createDirectory(at: alpha, withIntermediateDirectories: true)
        try FileManager.default.createDirectory(at: beta, withIntermediateDirectories: true)
        FileManager.default.createFile(atPath: alpha.appendingPathComponent("a.txt").path, contents: Data())
        FileManager.default.createFile(atPath: beta.appendingPathComponent("b.txt").path, contents: Data())

        let output = try captureStandardOutput {
            try TreeGenerator(
                path: root.path,
                depth: 10,
                includesHidden: false,
                isPretty: false,
                includesSummary: false
            ).generate()
        }

        XCTAssertEqual(
            output,
            """
            ├── alpha/
            │   └── a.txt
            └── beta/
                └── b.txt
            """
        )
    }

    func testUsesLastBranchForFinalDirectory() throws {
        let root = try makeTemporaryDirectory()
        let folder = root.appendingPathComponent("folder", isDirectory: true)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)

        let output = try captureStandardOutput {
            try TreeGenerator(
                path: root.path,
                depth: 10,
                includesHidden: false,
                isPretty: false,
                includesSummary: false
            ).generate()
        }

        XCTAssertEqual(
            output,
            """
            └── folder/
            """
        )
    }

    func testGeneratesTreeForLocalFilesystemPath() throws {
        let parent = try makeTemporaryDirectory()
        let root = parent.appendingPathComponent("folder with spaces", isDirectory: true)
        let nestedDirectory = root.appendingPathComponent("docs", isDirectory: true)
        try FileManager.default.createDirectory(at: nestedDirectory, withIntermediateDirectories: true)
        FileManager.default.createFile(
            atPath: nestedDirectory.appendingPathComponent("guide.md").path,
            contents: Data()
        )

        let output = try captureStandardOutput {
            try TreeGenerator(
                path: root.path,
                depth: 10,
                includesHidden: false,
                isPretty: false,
                includesSummary: false
            ).generate()
        }

        XCTAssertEqual(
            output,
            """
            └── docs/
                └── guide.md
            """
        )
    }

    func testIncludesSummaryInTerminalOutputWhenEnabled() throws {
        let root = try makeTemporaryDirectory()
        let folder = root.appendingPathComponent("folder", isDirectory: true)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("README.md").path,
            contents: Data()
        )

        let output = try captureStandardOutput {
            try TreeGenerator(
                path: root.path,
                depth: 10,
                includesHidden: false,
                isPretty: false,
                includesSummary: true
            ).generate()
        }

        XCTAssertEqual(
            output,
            """
            ├── README.md
            └── folder/

            1 directory, 1 file
            """
        )
    }

    func testAddsIconsForKnownFileTypesAndDirectoriesWhenPrettyIsEnabled() throws {
        let root = try makeTemporaryDirectory()
        let media = root.appendingPathComponent("media", isDirectory: true)
        try FileManager.default.createDirectory(at: media, withIntermediateDirectories: true)
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("archive.tar.gz").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("app.toml").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("clip.mp4").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent(".editorconfig").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("main.swift").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("installer.pkg").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("photo.png").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("notes.txt").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("README.md").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("mystery.bin").path,
            contents: Data()
        )

        let output = try captureStandardOutput {
            try TreeGenerator(
                path: root.path,
                depth: 10,
                includesHidden: false,
                isPretty: true,
                includesSummary: false
            ).generate()
        }

        XCTAssertEqual(
            output,
            """
            ├── 🗒️ README.md
            ├── ⚙️ app.toml
            ├── 📦 archive.tar.gz
            ├── 🎬 clip.mp4
            ├── 📦 installer.pkg
            ├── 💻 main.swift
            ├── 📁 media/
            ├── 📄 mystery.bin
            ├── 🗒️ notes.txt
            └── 🖼️ photo.png
            """
        )
    }

    func testLeavesKnownFilesPlainWhenPrettyIsDisabled() throws {
        let root = try makeTemporaryDirectory()
        let assets = root.appendingPathComponent("assets", isDirectory: true)
        try FileManager.default.createDirectory(at: assets, withIntermediateDirectories: true)
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("archive.tar.gz").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("main.swift").path,
            contents: Data()
        )
        FileManager.default.createFile(
            atPath: root.appendingPathComponent("poster.png").path,
            contents: Data()
        )

        let output = try captureStandardOutput {
            try TreeGenerator(
                path: root.path,
                depth: 10,
                includesHidden: false,
                isPretty: false,
                includesSummary: false
            ).generate()
        }

        XCTAssertEqual(
            output,
            """
            ├── archive.tar.gz
            ├── assets/
            ├── main.swift
            └── poster.png
            """
        )
    }

    private func makeTemporaryDirectory() throws -> URL {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        addTeardownBlock {
            try? FileManager.default.removeItem(at: url)
        }
        return url
    }

    private func captureStandardOutput(_ operation: () throws -> Void) throws -> String {
        let pipe = Pipe()
        let savedStdout = dup(STDOUT_FILENO)
        XCTAssertNotEqual(savedStdout, -1)

        fflush(stdout)
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)

        do {
            try operation()
        } catch {
            fflush(stdout)
            dup2(savedStdout, STDOUT_FILENO)
            close(savedStdout)
            pipe.fileHandleForWriting.closeFile()
            throw error
        }

        fflush(stdout)
        dup2(savedStdout, STDOUT_FILENO)
        close(savedStdout)
        pipe.fileHandleForWriting.closeFile()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        pipe.fileHandleForReading.closeFile()

        return String(decoding: data, as: UTF8.self)
            .trimmingCharacters(in: .newlines)
    }
}
