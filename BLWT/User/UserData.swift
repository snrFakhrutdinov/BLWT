//
//  UserData.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 21.04.2022.
//

import Foundation
import SwiftUI

class UserData: ObservableObject{
    @Published var name: String = ""
    @Published var id: Int  = 0
}
