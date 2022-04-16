//
//  UserMainUI.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 11.04.2022.
//

import SwiftUI
import UIKit

struct UserMainUI: View {
    @ObservedObject var data = UserData()
    var body: some View {
        HeaderUI()
    }
}

struct UserMainUI_Previews: PreviewProvider {
    static var previews: some View {
        UserMainUI()
    }
}

struct HeaderUI: View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 13)
                .frame(width: 390, height: 130, alignment: .center)
            VStack(spacing: 15){
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 390, height: 1, alignment: .center)
                    .foregroundColor(Color.gray)
                HStack{
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.white)
                        .font(.system(size: 40))
                        .frame(width: 45, height: 50, alignment: .leading)
                    VStack(alignment: .leading){
                        Text("nickname")
                        Text("#tags")
                    }
                    Spacer()
                    Image(systemName: "gear")
                        .font(.system(size: 40))
                }
                .frame(width: 365, height: 50, alignment: .leading)
                .foregroundColor(Color.white)
            }
            .frame(width: 390, height: 90, alignment: .bottom)
        }
        .position(x: 195, y: 15)
    }
}

struct BackgroundUI: View{
    var body: some View{
        RoundedRectangle(cornerRadius: 0)
            .foregroundColor(Color.gray)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BottomMenu: View{
    var body: some View{
        RoundedRectangle(cornerRadius: 13)
    }
}

struct UserUIMainBody: View{
    
    var body: some View{
        TabView{
            Text("a")
                .tabItem{
                    Image(systemName: "bubble.left")
                }
            Text("b")
                .tabItem{
                    Image(systemName: "person.2")
                }
            Text("c")
                .tabItem{
                    Image(systemName: "rectangle.stack.badge.person.crop")
                }
            Text("d")
                .tabItem{
                    Image(systemName: "folder")
                }
        }
        .accentColor(.green)
    }
}
