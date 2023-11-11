//
//  TreeGenerator.swift
//  SwiftyTree
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
        try generate(url: url, depth: depth)
        print("```")
    }
    
    func generate(url: URL, depth: Int, parent: String = "") throws {
        let contents = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: includesHidden ? [] : [.skipsHiddenFiles])
        let spacer = parent.isEmpty ? "" : "   "
        try contents.forEach { content in
            let suffix = content == contents.last && !content.hasDirectoryPath ? "└──" : "├──"
            print("\(parent)\(spacer)\(suffix) \(content.lastPathComponent)")
            guard depth > .zero && content.hasDirectoryPath else { return }
            try generate(url: content, depth: depth - 1, parent: parent.isEmpty ? "│" : "\(parent)\(spacer)│")
        }
    }
}
