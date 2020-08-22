//
//  Controller.swift
//  Debugger
//
//  Created by Andrew Tan on 2020-08-12.
//  Copyright © 2020 Andrew Tan. All rights reserved.
//

import Foundation

class Controller: ObservableObject {
    @Published var filteredEvents = UUID()
    @Published var workDir = ""
    @Published var events : [Event] = [
        Event(
            isParent: true,
            isChild: false,
            functionName: "MOMO",
            parentId: UUID(),
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
    ]
    
    func clearEvents() -> Void {
        self.events = []
    }
    func setWorkDir(string: String) -> Void {
        self.workDir = string
    }
}
