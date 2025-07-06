//
//  Project_BeatcodeApp.swift
//  Project-Beatcode
//
//  Created by Gina Saviano on 04/07/25.
//

import SwiftUI
import SwiftData

@main
struct Project_BeatcodeApp: App {    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: BookModel.self)
    }
}
