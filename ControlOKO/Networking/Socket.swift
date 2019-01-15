//
//  Socket.swift
//  OKO-Control
//
//  Created by iMAC on 07.10.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import UIKit
import AudioToolbox

protocol SocketStreamDelegate{
    func socketDidConnect(stream:Stream)
    func socketDidReceiveMessage(stream:Stream, message:String)
    func socketDidSendMessage(message:String)
    func socketErrorOccurred(stream:Stream)
}

class Socket: NSObject, StreamDelegate {
    
    var delegate:SocketStreamDelegate?
    
    private let serverAddress: CFString
    private let serverPort: UInt32
    private let bufferSize = 4096
    private var messagesQueue:Array<String> = [String]()
    private var inputStream: InputStream?
    private var outputStream: OutputStream?
    private var isOpen = false
    
    private var count = 0
    
    private var timer: Timer!
    
    var socketIsOpen: Bool {
        get {
            return self.isOpen
        }
    }
    
    init(server: String, port: Int) {
        self.serverAddress = server as CFString
        self.serverPort = UInt32(port)
    }
    
    deinit{
        stopSession()
    }
    
    /**
     Opens streaming for both reading and writing, error will be thrown if you try to send a message and streaming hasn't been opened
     :param: host String with host portion
     :param: port Port
     */
    final func setupNetworkCommunication (){
        
        if (inputStream != nil || outputStream != nil) {
            stopSession()
        }
        messagesQueue = Array()
        
        print("[SCKT]: Start session...")
        
        if #available(iOS 8.0, *) {
            Stream.getStreamsToHost(withName: serverAddress as String, port: Int(serverPort), inputStream: &inputStream, outputStream: &outputStream)
        } else {
            var inStreamUnmanaged:Unmanaged<CFReadStream>?
            var outStreamUnmanaged:Unmanaged<CFWriteStream>?
            CFStreamCreatePairWithSocketToHost(nil, serverAddress, serverPort, &inStreamUnmanaged, &outStreamUnmanaged)
            inputStream = inStreamUnmanaged?.takeRetainedValue()
            outputStream = outStreamUnmanaged?.takeRetainedValue()
        }
        
        if inputStream != nil && outputStream != nil {
            
            inputStream!.delegate = self
            outputStream!.delegate = self
            
            //inputStream?.setProperty(StreamNetworkServiceTypeValue.voIP.rawValue, forKey: Stream.PropertyKey.networkServiceType)
            //outputStream?.setProperty(StreamNetworkServiceTypeValue.voIP, forKey: Stream.PropertyKey.networkServiceType)
            
            inputStream!.schedule(in: .main, forMode: RunLoopMode.defaultRunLoopMode) //(in: .current, forMode: .commonModes)
            outputStream!.schedule(in: .main, forMode: RunLoopMode.defaultRunLoopMode) //(in: .current, forMode: .commonModes)
            
            inputStream!.open()
            outputStream!.open()
            
            /*
            // Set Keep Alive Timeout for 600 seconds Hadler
            UIApplication.shared.setKeepAliveTimeout (600, handler: {
                if ((self.outputStream) != nil)
                {
                    self.PeriodicQuery()
                }
                });
            */
            
            timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(Socket.PeriodicQuery), userInfo: nil, repeats: true)
            //RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
            //RunLoop.current.run()
            
            print("[SCKT]: Open Stream")
        } else {
            print("[SCKT]: Failed Getting Streams")
        }
    }
    
    final func stopSession(){
        if let inputStr = self.inputStream{
            inputStr.delegate = nil
            inputStr.close()
            inputStr.remove(from: .main, forMode: RunLoopMode.defaultRunLoopMode)
        }
        if let outputStr = self.outputStream{
            outputStr.delegate = nil
            outputStr.close()
            outputStr.remove(from: .main, forMode: RunLoopMode.defaultRunLoopMode)
        }
        print ("[SCKT]: Stop session")
        isOpen = false
        timer.invalidate()
    }
    
    /**
     NSStream Delegate Method where we handle errors, read and write data from input and output streams
     :param: stream NStream that called delegate method
     :param: eventCode      Event Code
     */
    final func stream(_ stream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case Stream.Event.endEncountered:
            endEncountered(stream: stream)
            break
        case Stream.Event.errorOccurred:
            errorOccurred(stream: stream)
            break
        case Stream.Event.openCompleted:
            openCompleted(stream: stream)
            break
        case Stream.Event.hasBytesAvailable:
            handleIncommingStream(stream: stream)
            break
        case Stream.Event.hasSpaceAvailable:
            print("[SCKT]: Space available")
            writeToStream()
            break
            
        default:
            break
        }
    }
    
    final func endEncountered(stream:Stream){
        
    }
    
    final func errorOccurred(stream:Stream){
        print("[SCKT]: ErrorOccurred: \(stream.streamError.debugDescription)")
        self.delegate?.socketErrorOccurred(stream: stream)
    }
    
    final func openCompleted(stream:Stream){
        if (self.inputStream?.streamStatus == .open && self.outputStream?.streamStatus == .open && !isOpen) {
            
            self.isOpen = true
            self.delegate?.socketDidConnect(stream: stream)
            
        }
    }
    
    final func sendMessage(message:String){
        messagesQueue.insert(message, at: 0)
        writeToStream()
    }
    
    /**
     Reads bytes asynchronously from incomming stream and calls delegate method socketDidReceiveMessage
     :param: stream An NSInputStream
     */
    final func handleIncommingStream(stream: Stream){
        if let inputStream = stream as? InputStream {
            var buffer = Array<UInt8>(repeating: 0, count: bufferSize)
            
            // Move to a background thread to do some long running work
            DispatchQueue.global(qos: .userInitiated).async { () -> Void in //qos: .background
                let bytesRead = inputStream.read(&buffer, maxLength: self.bufferSize)
                
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    if bytesRead >= 0 {
                        if let output = NSString(bytes: &buffer, length: bytesRead, encoding: String.Encoding.utf8.rawValue){
                            self.delegate?.socketDidReceiveMessage(stream: stream, message: output as String)
                            print("[SCKT]: Message received")
                            //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // vibration
                        }
                    } else {
                        // Handle error
                    }
                }
            }
            
        } else {
            print("[SCKT]: \(#function) : Incorrect stream received")
        }
        
    }
    
    /**
     If messages exist in _messagesQueue it will remove and it and send it, if there is an error
     it will return the message to the queue
     */
    final func writeToStream(){
        if outputStream!.hasSpaceAvailable  {
            DispatchQueue.global(qos: .userInitiated).async { () -> Void in
                if self.messagesQueue.count > 0 {
                    let message = self.messagesQueue.removeLast()
                    let data: NSData = message.data(using: String.Encoding.utf8)! as NSData
                    var buffer = [UInt8](repeating:0, count:data.length)
                    data.getBytes(&buffer, length:data.length * MemoryLayout<UInt8>.size)
                    let returnVal = self.outputStream!.write(&buffer, maxLength: data.length)
                    
                    DispatchQueue.main.async {
                        //An error ocurred when writing
                        if  returnVal == -1 {
                            self.messagesQueue.append(message)
                            print ("[SCKT]: error occurred when sending message")
                        }
                        else {
                            print("[SCKT]: Sent \(message)")
                            self.delegate?.socketDidSendMessage(message: message)
                            
                        }
                    }
                }
            }
        }
    }
    
    func PeriodicQuery() {
        sendMessage(message: "{0}\n")
        count += 1
        print ("count: \(count)")
        
    }

}


