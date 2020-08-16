//
//  Socket.swift
//  Debugger
//
//  Created by Andrew Tan on 2020-08-15.
//  Copyright © 2020 Andrew Tan. All rights reserved.
//

import Foundation
import SwiftSocket

class Socket {
    func start(contoller: Controller) {
        print("👁 Socket.start()")
        let backgroundQueue = DispatchQueue.global(qos: .background)
        backgroundQueue.async {
            let server = UDPServer(address: "", port: 8080)
            let run:Bool=true
        
            while run{
                let (data,remoteip,remoteport) = server.recv(1024)
                print("recive\(remoteip);\(remoteport)")
                if let d=data{
                    if let str=String(bytes: d, encoding: String.Encoding.utf8){
                        let decoder = JSONDecoder()
                        do {
                            let event = try decoder.decode(Event.self, from: Data(str.utf8))
                            DispatchQueue.main.async {
                                contoller.events.append(event)
                            }
                        } catch {
                            print("🤬", error.localizedDescription)
                        }
                    }
                }
                print(remoteip)
            }
        }
    }
}
