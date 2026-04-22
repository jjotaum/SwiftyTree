//
//  TreeGenerator.swift
//  Ceroxylon
//
//  Created by Jota Uribe on 22/10/23.
//

import Foundation

struct TreeGenerator {
    struct Summary {
        var directories: Int = 0
        var files: Int = 0
    }

    private let fileManager = FileManager.default
    let path: String
    let depth: Int
    let includesHidden: Bool
    let isPretty: Bool
    let includesSummary: Bool
    
    func generate() throws {
        let url = URL(fileURLWithPath: path)
        let summary = try generate(url: url, depth: depth, prefix: "")
        if includesSummary {
            print("")
            print("\(summary.directories) director\(summary.directories == 1 ? "y" : "ies"), \(summary.files) file\(summary.files == 1 ? "" : "s")")
        }
    }
    
    func generate(url: URL, depth: Int, prefix: String) throws -> Summary {
        var summary = Summary()
        let contents = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: includesHidden ? [] : [.skipsHiddenFiles]).sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
        for (index, content) in contents.enumerated() {
            let isLast = index == contents.count - 1
            let branch = isLast ? "└── " : "├── "
            if content.hasDirectoryPath {
                summary.directories += 1
                print("\(prefix)\(branch)\(displayName(for: content, isDirectory: true))/")
            } else {
                summary.files += 1
                print("\(prefix)\(branch)\(displayName(for: content, isDirectory: false))")
            }

            guard depth > .zero && content.hasDirectoryPath else { continue }
            let childPrefix = prefix + (isLast ? "    " : "│   ")
            let childSummary = try generate(url: content, depth: depth - 1, prefix: childPrefix)
            summary.directories += childSummary.directories
            summary.files += childSummary.files
        }
        return summary
    }

    private func displayName(for url: URL, isDirectory: Bool) -> String {
        let name = url.lastPathComponent
        guard isPretty else { return name }
        if isDirectory {
            return "\(Constants.directoryIcon) \(name)"
        }
        if Self.matchesExtension(in: name, against: Constants.packageExtensions) {
            return "\(Constants.packageIcon) \(name)"
        }
        if Self.matchesSettingsFile(name) {
            return "\(Constants.settingsIcon) \(name)"
        }
        if Self.matchesExtension(in: name, against: Constants.imageExtensions) {
            return "\(Constants.imageIcon) \(name)"
        }
        if Self.matchesExtension(in: name, against: Constants.videoExtensions) {
            return "\(Constants.videoIcon) \(name)"
        }
        if Self.matchesExtension(in: name, against: Constants.codeExtensions) {
            return "\(Constants.codeIcon) \(name)"
        }
        if Self.matchesExtension(in: name, against: Constants.textDocumentExtensions) {
            return "\(Constants.textDocumentIcon) \(name)"
        }
        return "\(Constants.unknownFileIcon) \(name)"
    }

    private static func matchesExtension(in name: String, against extensions: [String]) -> Bool {
        let lowercaseName = name.lowercased()
        return extensions.contains { lowercaseName.hasSuffix($0) }
    }

    private static func matchesSettingsFile(_ name: String) -> Bool {
        let lowercaseName = name.lowercased()
        return Constants.settingsFileNames.contains(lowercaseName)
            || matchesExtension(in: lowercaseName, against: Constants.settingsExtensions)
    }
}
