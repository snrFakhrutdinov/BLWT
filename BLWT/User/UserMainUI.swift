//
//  UserMainUI.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 11.04.2022.
//

import SwiftUI
import UIKit

struct UserMainUI: View {
    @StateObject var viewRouter: ViewRouter
    
    @StateObject var userData: UserData
    
    var body: some View {
        ZStack{
            UserUIMainBody(viewRouter: viewRouter, user: userData)
            HeaderUI(userData: userData)
        }
    }
}

struct UserMainUI_Previews: PreviewProvider {
    static var previews: some View {
        UserMainUI(viewRouter: ViewRouter(), userData: UserData())
    }
}

struct HeaderUI: View{
    @StateObject var userData: UserData
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
                            Text(userData.name)
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
    
//    init(){
//        UITabBar.appearance().backgroundColor = .black
//        UITabBar.appearance().unselectedItemTintColor = UIColor(CurrentColors.darkGreen)
//
//    }
    @StateObject var viewRouter:ViewRouter
    @StateObject var user:UserData
    var body: some View{
        TabView{
            ChatMenu(user: user, router: viewRouter)
            .tabItem{
                Image(systemName: "bubble.left")
            }
            Text("INFO")
                .tabItem{
                    Image(systemName: "person.text.rectangle")
                }
        }
        .accentColor(CurrentColors.green)
    }
}

struct ChatMenu: View{
    var user:UserData
    let chatRoom = ChatRoom()
    
    @StateObject var router: ViewRouter
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(CurrentColors.gray)
            
            VStack{
                Button("Enter chat"){
                    print("Process")
                }
                .frame(width: 390, height: 50, alignment: .center)
                .foregroundColor(Color.white)
                .background(CurrentColors.green)
            }
        }
    }
}

struct ActualChatView: View{
    @State var container:String = ""
    @State var isPressed: Bool = false
    
    @StateObject var user: UserData = UserData()
    @State var messages: [Message] = []
    
    let chatRoom = ChatRoom()
    var body: some View{
        VStack{
            ScrollView{
                ForEach(messages, id: \.self){ message in
                    Text(message.message)
                        .foregroundColor(Color.black)
                }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 390, height: 85)
                VStack(spacing: -25){
                    HStack(spacing: 5){
                        ZStack{
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 345, height: 25, alignment: .top)
                                .foregroundColor(CurrentColors.gray)
                            TextField(text: $container, label:{
                                Text("")
                            })
                            .foregroundColor(Color.white)
                            .placeholder(when: container.isEmpty, placeholder: {
                                Text("Enter here....")
                                    .foregroundColor(CurrentColors.green)
                                    .frame(width: 345, height: 25, alignment: .center)
                            })
                        }
                        Button(action: {
                            if(container.isEmpty){
                                return
                            }
//                            chatRoom.send(message: container)
                            var msg = Message(message: container, messageSender: .ourself, username: user.name)
                            print(msg.message)
                            messages.append(msg)
                            
                            
                        }, label: {
                            Image(systemName: "paperplane")
                                .font(.system(size: 24))
                                .foregroundColor(CurrentColors.green)
                        })
                    }
                    .frame(width: 390, height: 65, alignment: .top)
                    Text("BLWT")
                        .foregroundColor(CurrentColors.green)
                        .fontWeight(.bold)
                        .frame(width: 390, height: 30, alignment: .center)
                }
            }
            .frame(width: 390, height: 835, alignment: .bottom)
        }
    }
}


