//
//  UserDBList.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 10.04.2022.
//

import SwiftUI

struct UserDBList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<Users>
    
    var body: some View {
        List(users){ user in
            VStack{
                Text(user.login ?? "unknown")
            }
        }
    }
}

struct UserDBList_Previews: PreviewProvider {
    static var previews: some View {
        UserDBList()
    }
}
