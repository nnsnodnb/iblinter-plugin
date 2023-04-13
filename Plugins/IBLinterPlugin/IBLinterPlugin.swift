//
//  IBLinterPlugin.swift
//  
//
//  Created by Yuya Oka on 2023/04/13.
//

import PackagePlugin

@main
struct IBLinterPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        return [
            .buildCommand(
                displayName: "Run IBLinter for \(target.name)",
                executable: try context.tool(named: "iblinter").path,
                arguments: [
                    "lint"
                ],
                environment: [:]
            )
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension IBLinterPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        return [
            .buildCommand(
                displayName: "Run IBLinter for \(target.displayName)",
                executable: try context.tool(named: "iblinter").path,
                arguments: [
                    "lint"
                ],
                environment: [:]
            )
        ]
    }
}
#endif
