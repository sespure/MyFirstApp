//
//  MyFirstAppApp.swift
//  MyFirstApp
//
//  Created by sespure on 15.03.2026.
//

import SwiftUI
import SwiftData

@main
struct MyFirstAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
