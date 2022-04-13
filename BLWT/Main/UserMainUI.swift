//
//  UserMainUI.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 11.04.2022.
//

import SwiftUI

struct UserMainUI: View {
    @ObservedObject var data = UserData()
    var body: some View {
        ZStack{
            BackgroundUI()
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
    var body: some View{
        ZStack{
            VStack(spacing: -10){
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 390, height: 44, alignment: .center)
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 390, height: 72, alignment: .center)
                    HStack{
                        HStack{
                            Image(systemName: "person")
                                .foregroundColor(Color.white)
                                .font(.system(size: 25))
                            VStack(spacing: 0){
                                Text("name")
                                    .foregroundColor(Color.white)
                                    .frame(width: 43, height: 20)
                                Text("#tags")
                                    .foregroundColor(Color.white)
                                    .frame(width: 55, height: 20)
                            }
                        }
                        .frame(width: 100, height: 50, alignment: .leading)
                        Image(systemName: "gear")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                    }
                }
            }
            RoundedRectangle(cornerRadius: 0)
                .frame(width: 390, height: 1, alignment: .center)
                .foregroundColor(Color.gray)
        }
        .position(x: 195, y: 2)
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
