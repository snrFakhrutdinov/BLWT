//
//  BDList.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 09.04.2022.
//

import SwiftUI

struct BDList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<Users>
    
    var body: some View {
        List(users){ user in
            HStack{
                Text(user.login ?? "Unknown")
            }
        }
    }
}

struct BDList_Previews: PreviewProvider {
    static var previews: some View {
        BDList()
    }
}
