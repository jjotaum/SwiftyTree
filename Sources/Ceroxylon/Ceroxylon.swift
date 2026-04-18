//
//  Ceroxylon.swift
//  Ceroxylon
//
//  Created by Jota Uribe on 22/10/23.
//

import ArgumentParser
import Foundation

struct Ceroxylon: ParsableCommand {
    @Option(name: .shortAndLong, help: "The directory path")
    private var path: String?
    @Option(name: .shortAndLong, help: "The depth of the generated tree")
    private var depth: Int = 100
    @Flag(name: .long, help: "Includes hidden files in the generated tree.")
    private var hidden: Bool = false
    @Flag(name: .long, help: "Appends a summary of directories and files to the generated Markdown.")
    private var summary: Bool = false
    
    func run() throws {
        let generator = TreeGenerator(
            path: path ?? FileManager.default.currentDirectoryPath,
            depth: depth,
            includesHidden: hidden,
            includesSummary: summary
        )
        try generator.generate()
    }
}
