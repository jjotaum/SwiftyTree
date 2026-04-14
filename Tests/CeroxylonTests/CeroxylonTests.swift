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
                includesHidden: false
            ).generate()
        }

        XCTAssertEqual(
            output,
            """
            ```
            ├── alpha
            │   └── a.txt
            └── beta
                └── b.txt
            ```
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
                includesHidden: false
            ).generate()
        }

        XCTAssertEqual(
            output,
            """
            ```
            └── folder
            ```
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
