//
//  UnitConverter_macApp.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI
import SwiftData

@main
struct UnitConverter_macApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteConversion.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentViewMac()
                .modelContainer(sharedModelContainer)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About Unit Converter") {
                    NSApplication.shared.orderFrontStandardAboutPanel()
                }
            }
            
            CommandGroup(replacing: .newItem) { }
            
            CommandMenu("View") {
                Toggle("Dark Mode", isOn: $isDarkMode)
                    .keyboardShortcut("d", modifiers: [.command])
            }
            
            CommandMenu("Window") {
                Button("Show Main Window") {
                    NSApplication.shared.windows.first?.makeKeyAndOrderFront(nil)
                }
                .keyboardShortcut("m", modifiers: [.command])
            }
        }
    }
}
