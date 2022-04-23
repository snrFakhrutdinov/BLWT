//
//  Message.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 23.04.2022.
//

import Foundation

struct Message: Hashable{
  let message: String
  let senderUsername: String
  let messageSender: MessageSender
  
  init(message: String, messageSender: MessageSender, username: String) {
    self.message = message.withoutWhitespace()
    self.messageSender = messageSender
    self.senderUsername = username
  }
}

enum MessageSender {
  case ourself
  case someoneElse
}


extension String {
  func withoutWhitespace() -> String {
    return self.replacingOccurrences(of: "\n", with: "")
      .replacingOccurrences(of: "\r", with: "")
      .replacingOccurrences(of: "\0", with: "")
  }
}
