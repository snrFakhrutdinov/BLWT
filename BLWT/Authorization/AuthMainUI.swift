//
//  AuthMainUI.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 09.04.2022.
//

import SwiftUI
import UIKit

struct AuthMainUI: View {
    
    @State var viewRouter: ViewRouter
    @StateObject var userData: UserData
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color.gray)
            MainBody(viewRouter: viewRouter, userData: userData)
        }
    }
}

struct AuthMainUI_Previews: PreviewProvider {
    static var previews: some View {
        AuthMainUI(viewRouter: ViewRouter(), userData: UserData())
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
    
    @StateObject var viewRouter: ViewRouter
    
    @StateObject var userData:UserData
    
    @State var isShowedLoginErrorAlert: Bool = false
    @State var isShowedUserBeenErrorAlert: Bool = false
    @State var isShowedPasswordErrorAlert: Bool = false
    
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
                        Button(action: {
                            for userInDB in users {
                                if userInDB.login == loginRegContainer{
                                    print(loginRegContainer)
                                    isShowedUserBeenErrorAlert = true
                                    return
                                }
                            }
                            if(loginRegContainer == "" || emailRegContainer == "" || passwordRegContainer == "" ){
                                isShowedLoginErrorAlert = true
                            }
                            if passwordRegContainer != confirmRegContainer {
                                isShowedPasswordErrorAlert = true
                                print("Error: your password is not match")
                                return
                            }
                            do{
                                let newUser = Users(context: moc)
                                newUser.login = loginRegContainer
                                newUser.email = emailRegContainer
                                newUser.password = passwordRegContainer
                                newUser.id = UUID()
                                try moc.save()
                                userData.name = loginRegContainer
                                userData.id = newUser.id.hashValue
                                viewRouter.currentPage = .userMain
                                print("newUser is added")
                            } catch{
                                print(error)
                            }
                        }, label: {
                            Text("Register")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                        })
                        .alert("Your field is empty", isPresented:$isShowedLoginErrorAlert, actions: {
                            Button("OK", role: .cancel){ }
                        })
                        .alert("This User is already register", isPresented:$isShowedUserBeenErrorAlert, actions: {
                            Button("OK", role: .cancel){ }
                        })
                        .alert("Passwords don't match", isPresented:$isShowedPasswordErrorAlert, actions: {
                            Button("OK", role: .cancel){ }
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
    
    @StateObject var viewRouter: ViewRouter
    
    @StateObject var userData: UserData
    
    @State var isShowedAlert: Bool = false
    
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
                        Button(action: {
                            for userInDB in users{
                                if userInDB.login == firstLogContainer && userInDB.password == secondLogContainer{
                                    print("Logged")
                                    userData.name = firstLogContainer
                                    userData.id = userInDB.id.hashValue
                                    viewRouter.currentPage = .userMain
                                }
                                else{
                                    isShowedAlert = true
                                }
                            }
                        }, label: {
                            Text("Login")
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                        })
                        .alert("Incorect Data ", isPresented: $isShowedAlert, actions: {
                            Button("OK", role: .cancel){ }
                        })
                    }
                }
            }
        }
    }
}


struct MainBody: View{
    
    
    @StateObject var viewRouter: ViewRouter
    
    @StateObject var userData: UserData
    
    var body: some View{
                TabView{
                    SwipedRegBody(viewRouter: viewRouter, userData: userData)
                        .tabItem{
                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                .font(.system(size: 50))
                        }
                    SwipedLogBody(viewRouter: viewRouter, userData: userData)
                        .tabItem{
                            Image(systemName: "person.crop.circle.badge.questionmark.fill")
                                .font(.system(size: 50))
                        }
                }
                .accentColor(CurrentColors.green)
                .shadow(radius: 10)
                .background(.black)
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
