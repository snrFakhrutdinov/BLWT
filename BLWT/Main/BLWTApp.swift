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
    
    @StateObject var viewRouter = ViewRouter()
    
    @StateObject var userData = UserData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter, userData: userData)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
	
