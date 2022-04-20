//
//  UserMainUI.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 11.04.2022.
//

import SwiftUI
import UIKit

struct UserMainUI: View {
    var userLogin: String
    var userID: Int
    @State var currentUser: User
    
    init(userName: String, id: Int){
        self.userLogin = userName
        self.userID = id
        currentUser = User(name: self.userLogin, id: self.userID)
    }
    var body: some View {
        ZStack{
            UserUIMainBody(user: $currentUser)
            HeaderUI(name: userLogin, id: userID)
        }
    }
}

struct UserMainUI_Previews: PreviewProvider {
    static var previews: some View {
        UserMainUI(userName: "a", id: 1)
    }
}

struct HeaderUI: View{
    @ObservedObject var currentUser = UserData()
    var name:String
    var id: Int
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
                            Text(name)
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
    @Binding var user:User
    
    init(){
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().unselectedItemTintColor = UIColor(CurrentColors.darkGreen)
    }
    
    var body: some View{
        TabView{
            ChatMenu()
            .tabItem{
                Image(systemName: "bubble.left")
            }
            FriendView(user: user)
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
        VStack{
            Button("New Chat"){
                print("Process")
            }
            .frame(width: 390, height: 25, alignment: .center)
            .foregroundColor(Color.white)
            .background(CurrentColors.green)
        }
        .frame(width: 390, height: 615, alignment: .topLeading)
    }
}

struct ChatValuableElement: View{
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<Users>
    
    var userName:String
    var body: some View{
        Button(action: {
            print("Sending")
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.black)
                    .frame(width: 390, height: 60)
                HStack{
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 35))
                    VStack(alignment: .leading, spacing: 0){
                        Text(userName)
                            .fontWeight(.bold)
                        Text("#tags")
                            .foregroundColor(CurrentColors.lightGreen)
                    }
                }
                .frame(width: 375, alignment: .leading)
            }
        })
    }
}

struct FriendList: View{
    @State var user:User
    var body: some View{
        ForEach(0..<user.friends.count){ friend in
            VStack{
                Text("Friend: \(friend)")
            }
        }
    }
}
    
struct FriendView: View{
    @State var user: User
    var body: some View{
        Text("a")
    }
}
