//
//  TreeGenerator.swift
//  Ceroxylon
//
//  Created by Jota Uribe on 22/10/23.
//

import Foundation

struct TreeGenerator {
    private let fileManager = FileManager.default
    let path: String
    let depth: Int
    let includesHidden: Bool
    
    func generate() throws {
        guard let url = URL(string: path) else { throw URLError(.badURL) }
        print("```")
        try generate(url: url, depth: depth, prefix: "")
        print("```")
    }
    
    func generate(url: URL, depth: Int, prefix: String) throws {
        let contents = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: includesHidden ? [] : [.skipsHiddenFiles]).sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
        for (index, content) in contents.enumerated() {
            let isLast = index == contents.count - 1
            let branch = isLast ? "└── " : "├── "
            print("\(prefix)\(branch)\(content.lastPathComponent)")
            guard depth > .zero && content.hasDirectoryPath else { continue }
            let childPrefix = prefix + (isLast ? "    " : "│   ")
            try generate(url: content, depth: depth - 1, prefix: childPrefix)
        }
    }
}
