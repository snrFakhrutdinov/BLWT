//
//  User.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 20.04.2022.
//

import Foundation
import SwiftUI

class User{
    var name: String
    var id: Int
    var friends: [Int] = []
    var tags: [String] = []
    
    init(name: String, id:Int){
        self.name = name
        self.id = id
    }
    
    func AddFriend(friendID: Int){
        friends.append(friendID)
    }
    
    func AddTag(tag: String){
        tags.append(tag)
    }
    
    func AddTag(tags: [String]){
        for tag in tags {
            self.tags.append(tag)
        }
    }
    
}


