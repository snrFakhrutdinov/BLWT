//
//  ContentView.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 09.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewRouter: ViewRouter
    @StateObject var userData: UserData
    
    var body: some View {
        switch viewRouter.currentPage {
        case .auth:
            AuthMainUI(viewRouter: viewRouter, userData: userData)
        case .userMain:
            UserMainUI(viewRouter: viewRouter, userData: userData)
        case .chat:
            ActualChatView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter(), userData: UserData())
    }
}
