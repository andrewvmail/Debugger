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
    @State var items = Array(1...600)
    
    var body: some View {
            VStack {
                List(items, id: \.self) {
                    Text("\($0)…")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .id(UUID())
            }
    }
}
struct Middle: View {
    var body: some View {
        Text("Middle")
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
