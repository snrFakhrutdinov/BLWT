import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "UsersDB")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error{
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
}
