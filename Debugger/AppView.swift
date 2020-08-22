//
//  ContentView.swift
//  Debugger
//
//  Created by Andrew Tan on 2020-06-12.
//  Copyright © 2020 Andrew Tan. All rights reserved.
//

import SwiftUI

struct AppView : View {
    @EnvironmentObject var controller: Controller
    @State var workDir: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    TextField(
                        "Enter working directory...",
                        text: self.$workDir,
                        onCommit: {
                            self.controller.setWorkDir(string: self.workDir)
                    })
                    Button(action: {
                        print("Delete button tapped!")
                        self.controller.clearEvents()
                    }) {
                        Text("Clear")
                    }
                }
                HStack {
                    Left()
                        .frame(maxWidth: geometry.size.width / 5, maxHeight: .infinity)
                    //                    .background(Color.red)
                    
                    Middle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue)
                    
                    Right()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.green)
                }
            }
        }
    }
}

struct Left: View {
    @EnvironmentObject var controller: Controller
    
    var body: some View {
        VStack {
            List(controller.events.filter {$0.isParent}, id: \.self) { item in
                Button(action: {
                    self.controller.filteredEvents = item.parentId
                }) {
                   Text(item.functionName)
                }
//                Text(item.functionName)
//                    .font(.body)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .onTapGesture {
//                        self.controller.filteredEvents = item.parentId
//                        print("tapped left view \(item.source)")
//                        //                        print("Function: \(#function), line: \(#line) \(#file)")
//
//
//                }
            }
            .id(UUID())
            
        }
    }
}
struct Middle: View {
    @EnvironmentObject var controller: Controller
    
    var body: some View {
        VStack {
            List(controller.events.filter {$0.parentId == controller.filteredEvents}, id: \.self) {  item in
                HStack {
                    Text(item.functionName)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            print("tapped middle view \(item.source)")
                    }
                    Button(action: {
//                        let pasteBoard = NSPasteboard.general
//                        pasteBoard.clearContents()
//                        pasteBoard.setString("subl " + self.controller.workDir + item.source, forType: .string)
                        
                        let task = Process()
                        task.launchPath = "/Users/momo/bin/subl"
                        task.arguments = ["/Users/momo/Desktop/" + item.source]
                        task.launch()
                        
                    }) {
                        Text(item.source)
                    }
                }
            }
            .id(UUID())
        }
    }
}
struct Right: View {
    var body: some View {
        Text("Right")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
