//
//  ChatRoom.swift
//  BLWT
//
//  Created by snr_Fakhrutdinov on 23.04.2022.
//

import Foundation

protocol ChatRoomDelegate: class {
  func received(message: Message)
}

class ChatRoom: NSObject{
    
    weak var delegate: ChatRoomDelegate?
    
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    var userName = ""
    
    let maxLength = 4096
    
    
    func setupNetCommunication(){
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "localhost" as! CFString, 80, &readStream, &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream.delegate = self
        
        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)
        
        inputStream.open()
        outputStream.open()
    }
    
    func joinChat(userName: String) {
        let data = "iam:\(userName)".data(using: .utf8)!
        
        self.userName = userName
        
        _ = data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error joining chat")
                return
            }
            outputStream.write(pointer, maxLength: data.count)
        }
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
          print("new message received")
        case .endEncountered:
          print("The end of the stream has been reached.")
            stopChatSession()
        case .errorOccurred:
          print("error occurred")
        case .hasSpaceAvailable:
          print("has space available")
          readAvailableBytes(stream: aStream as! InputStream)
        default:
          print("some other event...")
        }
    }
    
    private func readAvailableBytes(stream: InputStream) {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxLength)
        
        while stream.hasBytesAvailable {
            let numberOfBytesRead = inputStream.read(buffer, maxLength: maxLength)
            
            if numberOfBytesRead < 0, let error = stream.streamError {
                print(error)
                break
            }
            
            if let message = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
                delegate?.received(message: message)
            }
        }
    }
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>,
                                        length: Int) -> Message? {
      guard let stringArray = String(
          bytesNoCopy: buffer,
          length: length,
          encoding: .utf8,
          freeWhenDone: true)?.components(separatedBy: ":"),
        let name = stringArray.first,
        let message = stringArray.last
        else {
          return nil
      }
      let messageSender: MessageSender =
        (name == self.userName) ? .ourself : .someoneElse
      return Message(message: message, messageSender: messageSender, username: name)
    }
    
    func send(message: String) {
      let data = "msg:\(message)".data(using: .utf8)!

      _ = data.withUnsafeBytes {
        guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
          print("Error joining chat")
          return
        }
        outputStream.write(pointer, maxLength: data.count)
      }
    }
    func stopChatSession(){
        inputStream.close()
        outputStream.close()
    }
}


extension ChatRoom: StreamDelegate {
}
