//
//  BLWTApp.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 09.04.2022.
//

import SwiftUI

@main
struct BLWTApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
