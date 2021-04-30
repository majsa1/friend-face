//
//  FriendFace_day_61_v1App.swift
//  FriendFace day 61 v1
//
//  Created by Marjo Salo on 28/04/2021.
//

import SwiftUI

@main
struct FriendFace_day_61_v1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
