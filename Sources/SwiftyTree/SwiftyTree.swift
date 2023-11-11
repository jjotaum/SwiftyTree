//
//  SwiftyTree.swift
//  SwiftyTree
//
//  Created by Jota Uribe on 22/10/23.
//

import ArgumentParser
import Foundation

struct SwiftyTree: ParsableCommand {
    @Option(name: .shortAndLong, help: "The directory path")
    private var path: String?
    @Option(name: .shortAndLong, help: "The depth of the generated tree")
    private var depth: Int = 100
    @Option(name: .shortAndLong, help: "Defines if generated tree includes hidden files.")
    private var hidden: Bool = false
    
    func run() throws {
        let generator = TreeGenerator(
            path: path ?? FileManager.default.currentDirectoryPath,
            depth: depth,
            includesHidden: hidden
        )
        try generator.generate()
    }
}
