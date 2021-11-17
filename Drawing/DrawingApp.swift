//
//  DrawingApp.swift
//  Drawing
//
//  Created by prediction on 2021/11/17.
//

import SwiftUI

@main
struct DrawingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
