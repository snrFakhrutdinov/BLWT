//
//  AuthMainUI.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 09.04.2022.
//

import SwiftUI
import UIKit

struct AuthMainUI: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color.gray)
                MainBody()
        }
    }
}

struct AuthMainUI_Previews: PreviewProvider {
    static var previews: some View {
        AuthMainUI()
    }
}

struct SwipedRegBody: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<Users>
    
    @State var loginRegContainer:String = ""
    @State var emailRegContainer:String = ""
    @State var passwordRegContainer:String = ""
    @State var confirmRegContainer:String = ""
    
    @State var isRegistered: Bool = false
    
    @ObservedObject var currentUser = UserData()
    
    var body: some View{
        NavigationView{
            ZStack(){
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(CurrentColors.gray)
                    .edgesIgnoringSafeArea(.all)
                RoundedRectangle(cornerRadius: 13)
                    .frame(width: 342, height: 475, alignment: .center)
                VStack(spacing: 72){
                    Text("BLWT")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 390, height: 24, alignment: .center)
                        .foregroundColor(CurrentColors.green)
                    VStack(spacing: 48){
                        VStack(spacing: 4){
                            Text("Login")
                                .fontWeight(.semibold)
                                .frame(width: 320, height: 24, alignment: .leading)
                                .foregroundColor(CurrentColors.green)
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 320, height: 24, alignment: .leading)
                                    .foregroundColor(CurrentColors.gray)
                                TextField(text: $loginRegContainer, label: {
                                    Text("")
                                })
                                .placeholder(when: loginRegContainer.isEmpty, placeholder: {
                                    Text("Enter here...")
                                        .foregroundColor(CurrentColors.green)
                                        .frame(width: 325, height: 20, alignment: .center)
                                })
                                .frame(width: 320, height: 24, alignment: .leading)
                            }
                            VStack(spacing: 0){
                                Text("Email")
                                    .fontWeight(.semibold)
                                    .frame(width: 320, height: 24, alignment: .leading)
                                    .foregroundColor(CurrentColors.green)
                                ZStack{
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 320, height: 24, alignment: .leading)
                                        .foregroundColor(CurrentColors.gray)
                                    TextField(text: $emailRegContainer, label: {
                                        Text("")
                                    })
                                    .placeholder(when: emailRegContainer.isEmpty, placeholder: {
                                        Text("Enter here...")
                                            .foregroundColor(CurrentColors.green)
                                            .frame(width: 325, height: 20, alignment: .center)
                                    })
                                    .frame(width: 320, height: 24, alignment: .leading)
                                }
                                
                            }
                            VStack(spacing: 0){
                                Text("Password")
                                    .fontWeight(.semibold)
                                    .frame(width: 320, height: 24, alignment: .leading)
                                    .foregroundColor(CurrentColors.green)
                                ZStack{
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 320, height: 24, alignment: .leading)
                                        .foregroundColor(CurrentColors.gray)
                                    TextField(text: $passwordRegContainer, label: {
                                        Text("")
                                    })                                .placeholder(when: passwordRegContainer.isEmpty, placeholder: {
                                        Text("Enter here...")
                                            .foregroundColor(CurrentColors.green)
                                            .frame(width: 325, height: 20, alignment: .center)
                                    })
                                    .frame(width: 320, height: 24, alignment: .leading)
                                }
                                
                            }
                            VStack(spacing: 0){
                                Text("Confirm Password")
                                    .fontWeight(.semibold)
                                    .frame(width: 320, height: 24, alignment: .leading)
                                    .foregroundColor(CurrentColors.green)
                                ZStack{
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 320, height: 24, alignment: .leading)
                                        .foregroundColor(CurrentColors.gray)
                                    TextField(text: $confirmRegContainer, label: {
                                        Text("")
                                    })
                                    .placeholder(when: confirmRegContainer.isEmpty, placeholder: {
                                        Text("Enter here...")
                                            .foregroundColor(CurrentColors.green)
                                            .frame(width: 325, height: 20, alignment: .center)
                                    })
                                    .frame(width: 320, height: 24, alignment: .leading)
                                }
                                
                            }
                            
                        }
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(CurrentColors.green)
                            .frame(width: 320, height: 24, alignment: .leading)
                        //add A Navigation link here
                        NavigationLink(destination: UserMainUI(), isActive: $isRegistered){EmptyView()}
                        Button(action: {
                            for userInDB in users {
                                if userInDB.login == loginRegContainer{
                                    print(loginRegContainer)
                                    print("Error: this login is already in use")
                                    return
                                }
                            }
                            if passwordRegContainer != confirmRegContainer {
                                print("Error: your password is not match")
                                return
                            }
                            do{
                                let newUser = Users(context: moc)
                                newUser.login = loginRegContainer
                                newUser.email = emailRegContainer
                                newUser.password = passwordRegContainer
                                newUser.id = UUID()
                                currentUser.name = loginRegContainer
                                try moc.save()
                                isRegistered = true
                                
                                print("newUser is added")
                            } catch{
                                print(error)
                            }
                        }, label: {
                            Text("Register")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                        })
                    }
                }
            }
        }
    }
}

struct SwipedLogBody: View{
    @State var firstLogContainer: String = ""
    @State var secondLogContainer: String = ""
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<Users>
    
    @ObservedObject var data = UserData()
    @State var isLoggined: Bool = false
    
    var body: some View{
        NavigationView{
            ZStack(){
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(CurrentColors.gray)
                    .edgesIgnoringSafeArea(.all)
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 342, height: 496, alignment: .center)
                VStack(spacing: 145){
                    Text("BLWT")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 390, height: 24, alignment: .center)
                        .foregroundColor(CurrentColors.green)
                    VStack(spacing: 8){
                        VStack(spacing: 0){
                            Text("Login")
                                .fontWeight(.semibold)
                                .frame(width: 320, height: 24, alignment: .leading)
                                .foregroundColor(CurrentColors.green)
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 320, height: 24, alignment: .leading)
                                    .foregroundColor(CurrentColors.gray)
                                TextField(text: $firstLogContainer, label: {
                                    Text("")
                                })
                                .placeholder(when: firstLogContainer.isEmpty, placeholder: {
                                    Text("Enter here...")
                                        .foregroundColor(CurrentColors.green)
                                        .frame(width: 325, height: 20, alignment: .center)
                                })
                                .frame(width: 320, height: 24, alignment: .leading)
                            }
                            
                        }
                        VStack(spacing: 0){
                            Text("Password")
                                .fontWeight(.semibold)
                                .frame(width: 320, height: 24, alignment: .leading)
                                .foregroundColor(CurrentColors.green)
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(width: 320, height: 24, alignment: .leading)
                                    .foregroundColor(CurrentColors.gray)
                                TextField(text: $secondLogContainer, label: {
                                    Text("")
                                })
                                .placeholder(when: secondLogContainer.isEmpty, placeholder: {
                                    Text("Enter here...")
                                        .foregroundColor(CurrentColors.green)
                                        .frame(width: 325, height: 20, alignment: .center)
                                })
                                .frame(width: 320, height: 24, alignment: .leading)
                            }
                            
                        }
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(CurrentColors.green)
                            .frame(width: 320, height: 24, alignment: .leading)
                        NavigationLink(destination: UserMainUI(), isActive: $isLoggined){ EmptyView() }
                        Button(action: {
                            for userInDB in users{
                                if userInDB.login == firstLogContainer && userInDB.password == secondLogContainer{
                                    print("Logged")
                                    data.name = firstLogContainer
                                    isLoggined = true
                                }
                            }
                        }, label: {
                            Text("Login")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                        })
                    }
                }
            }
        }
    }
}


struct MainBody: View{
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor(Color.black)
        UITabBar.appearance().unselectedItemTintColor = UIColor(CurrentColors.darkGreen)
    }
    
    var body: some View{
                TabView{
                    SwipedRegBody()
                        .tabItem{
                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                .font(.system(size: 50))
                        }
                    SwipedLogBody()
                        .tabItem{
                            Image(systemName: "person.crop.circle.badge.questionmark.fill")
                                .font(.system(size: 50))
                        }
                }
                .accentColor(CurrentColors.green)
                .shadow(radius: 10)
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
