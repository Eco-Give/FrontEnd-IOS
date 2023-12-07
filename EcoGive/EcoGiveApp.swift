//
//  EcoGiveApp.swift
//  EcoGive
//
//  Created by oumayma cherif on 24/11/2023.
//

import SwiftUI

@main
struct EcoGiveApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavBarView()
        }
    }
}
