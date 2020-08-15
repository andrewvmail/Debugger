//
//  Controller.swift
//  Debugger
//
//  Created by Andrew Tan on 2020-08-12.
//  Copyright © 2020 Andrew Tan. All rights reserved.
//

import Foundation

class Controller: ObservableObject {
    @Published var filteredEvents = ""
    @Published var events : [Event] = [
        Event(
            isParent: true,
            sequenceId: UUID() ,
            sequenceName: "momo123",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: true,
            sequenceId: UUID() ,
            sequenceName: "momo123",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
        Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ), Event(
            isParent: false,
            sequenceId: UUID() ,
            sequenceName: "momo",
            actionName: "MOMO",
            id: UUID(),
            source: "MOMO",
            name: "MOMO",
            details: "MOO"
        ),
    ]
    
}
