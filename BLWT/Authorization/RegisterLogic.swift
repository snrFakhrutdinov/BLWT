import Foundation
import SwiftUI

class Register{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<Users>
    
    @ObservedObject var props = Properties()
    
    func registerUser(){
        do{
            let user = Users(context: moc)
            user.login = props.fstRegContainer
            user.email = props.sndRegContainer
            user.password = props.trdRegContainer
            try moc.save()
        } catch{
            print(error)
        }
    }
}
