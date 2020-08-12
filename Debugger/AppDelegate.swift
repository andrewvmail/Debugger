//
//  AppDelegate.swift
//  Debugger
//
//  Created by Andrew Tan on 2020-06-12.
//  Copyright © 2020 Andrew Tan. All rights reserved.
//

import Cocoa
import SwiftUI
import SwiftSocket

var message = ""

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = AppView()
        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
//        testServer()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
public func track(_ message: String, file: String = #file, function: String = #function, line: Int = #line ) {
    print("\(message) called from \(function) \(file):\(line)")
}
func testServer() {
    let server = TCPServer(address: "127.0.0.1", port: 8080)
    switch server.listen() {
    case .success:
        while true {
            if var client = server.accept() {
                echoService(client: client)
            } else {
                print("accept error")
            }
        }
    case .failure(let error):
        print(error)
    }
}
func echoService(client: TCPClient) {
    print("Newclient from:\(client.address)[\(client.port)]")
    while true {
        guard let d = client.read(1, timeout: 1) else { continue }
        
        let c = String(bytes: d, encoding: .utf8)
        message += c!
        
        if (c == "\n") {        // '\n'
            do {
                
                track("enters app")
                print("hi")
                print(message)
                print(message.count)
            }
        }
    }
    client.close()
}

