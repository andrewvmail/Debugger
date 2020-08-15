//
//  ContentView.swift
//  Debugger
//
//  Created by Andrew Tan on 2020-06-12.
//  Copyright © 2020 Andrew Tan. All rights reserved.
//

import SwiftUI

struct AppView : View {
    var body: some View {
        GeometryReader { geometry in
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

struct Left: View {
    @EnvironmentObject var controller: Controller
    
    var body: some View {
        VStack {
            List(controller.events.filter {$0.isParent}, id: \.self) { item in
                Text("\(item.id)…")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        self.controller.filteredEvents = item.sequenceName
                        print("tapped left view \(item.sequenceName)")
                        print("Function: \(#function), line: \(#line) \(#file)") 
                        
                        
                }
            }
            .id(UUID())
        }
    }
}
struct Middle: View {
    @EnvironmentObject var controller: Controller
    
    var body: some View {
        VStack {
            List(controller.events.filter {$0.sequenceName == controller.filteredEvents}, id: \.self) {
                Text("\($0.details)…")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        
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
