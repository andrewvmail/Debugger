//
//  ContentView.swift
//  Debugger
//
//  Created by Andrew Tan on 2020-06-12.
//  Copyright © 2020 Andrew Tan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            NavigationView {
                List {
                    Text("Sequence")
                    Text("Here")
                }.frame(minWidth: 250, maxWidth: 350)
            }
            .listStyle(SidebarListStyle()) // Detail view actions
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // right side
            List {
                Text("State")
                Text("Here")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
