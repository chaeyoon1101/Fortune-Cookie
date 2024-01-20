//
//  FortuneCookieApp.swift
//  FortuneCookie
//
//  Created by 임채윤 on 1/21/24.
//

import SwiftUI

@main
struct FortuneCookieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
