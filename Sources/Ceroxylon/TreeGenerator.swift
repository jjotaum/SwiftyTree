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
                print("\(prefix)\(branch)\(content.lastPathComponent)/")
            } else {
                summary.files += 1
                print("\(prefix)\(branch)\(content.lastPathComponent)")
            }

            guard depth > .zero && content.hasDirectoryPath else { continue }
            let childPrefix = prefix + (isLast ? "    " : "│   ")
            let childSummary = try generate(url: content, depth: depth - 1, prefix: childPrefix)
            summary.directories += childSummary.directories
            summary.files += childSummary.files
        }
        return summary
    }
}
