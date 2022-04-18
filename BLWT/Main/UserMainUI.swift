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
        ZStack{
            UserUIMainBody()
            HeaderUI()
        }
    }
}

struct UserMainUI_Previews: PreviewProvider {
    static var previews: some View {
        UserMainUI()
    }
}

struct HeaderUI: View{
    @ObservedObject var currentUser = UserData()
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .frame(width: 390, height: 100, alignment: .center)
            VStack(){
                Spacer()
                    .frame(width: 390, height: 40, alignment: .center)
                HStack{
                    HStack{
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 30))
                            .foregroundColor(CurrentColors.green)
                        VStack(alignment: .leading){
                            Text(currentUser.name)
                                .foregroundColor(CurrentColors.white)
                            Text("#tags")
                                .foregroundColor(CurrentColors.lightGreen)
                        }
                    }
                    .frame(width: 320, height: 50, alignment: .leading)
                    Image(systemName: "gearshape")
                        .font(.system(size: 30))
                        .foregroundColor(CurrentColors.green)
                }
            }
        }
        .position(x: 195, y: 0)
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
    
    init(){
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().unselectedItemTintColor = UIColor(CurrentColors.darkGreen)
    }
    
    var body: some View{
        TabView{
            ZStack{
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(CurrentColors.gray)
                    .edgesIgnoringSafeArea(.all)
                Text("a")
            }
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
        .accentColor(CurrentColors.green)
    }
}
struct ChatMenu: View{
    var body: some View{
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 390, height: 80, alignment: .center)
    }
}


