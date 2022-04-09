//
//  AuthMainUI.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 09.04.2022.
//

import SwiftUI

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
    var register = Register()
    @ObservedObject var props = Properties()
    var body: some View{
        ZStack(){
            RoundedRectangle(cornerRadius: 13)
                .foregroundColor(Color.black)
                .frame(width: 342, height: 496, alignment: .center)
            VStack(spacing: 72){
                Text("BLWT")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 390, height: 24, alignment: .center)
                    .foregroundColor(Color.green)
                VStack(spacing: 24){
                    SwipedViewCell(fieldName: "Username", container: props.fstRegContainer)
                    SwipedViewCell(fieldName: "Email", container: props.fstRegContainer)
                    SwipedViewCell(fieldName: "Password", container: props.fstRegContainer)
                    SwipedViewCell(fieldName: "Confirm Password", container: props.fstRegContainer)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(Color.green)
                        .frame(width: 320, height: 24, alignment: .leading)
                    Button(action: {
                        register.registerUser()
                    }, label: {
                        Text("Register")
                            .foregroundColor(Color.white)
                    })
                }
            }
        }
    }
}
struct SwipedLogBody: View{
    @ObservedObject var props = Properties()
    var body: some View{
        ZStack(){
            RoundedRectangle(cornerRadius: 13)
                .foregroundColor(Color.black)
                .frame(width: 342, height: 496, alignment: .center)
            VStack(spacing: 145){
                Text("BLWT")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 390, height: 24, alignment: .center)
                    .foregroundColor(Color.green)
                VStack(spacing: 24){
                    SwipedViewCell(fieldName: "Login", container: props.fstRegContainer)
                    SwipedViewCell(fieldName: "Password", container: props.fstRegContainer)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(Color.green)
                        .frame(width: 320, height: 24, alignment: .leading)
                    Button(action: {
                        print("a")
                    }, label: {
                        Text("Register")
                            .foregroundColor(Color.white)
                    })
                }
            }
        }
    }
}

struct SwipedViewCell: View{
    var fieldName: String
    @State var container: String
    var body: some View{
        VStack(spacing: 0){
            Text(fieldName)
                .fontWeight(.semibold)
                .frame(width: 320, height: 24, alignment: .leading)
                .foregroundColor(Color.green)
            ZStack{
                TextField(text: $container, label: {
                    Text("")
                })
                .frame(width: 320, height: 24, alignment: .leading)
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 320, height: 24, alignment: .leading)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct MainBody: View{
    @State var swipedIndex: Int = 0
    var body: some View{
        TabView{
            SwipedRegBody()
                .tag(0)
            SwipedLogBody()
                .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
