//
//  FriendFace_day_61_v2App.swift
//  FriendFace day 61 v2
//
//  Created by Marjo Salo on 29/04/2021.
//

import SwiftUI

@main
struct FriendFace_day_61_v2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
