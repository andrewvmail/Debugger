//
//  Event.swift
//  Debugger
//
//  Created by Andrew Tan on 2020-08-12.
//  Copyright © 2020 Andrew Tan. All rights reserved.
//

import Foundation

struct Event: Hashable, Codable {
    var isParent: Bool
    var sequenceId: UUID
    var sequenceName: String
    var actionName: String
    var id: UUID
    var source: String
    var name: String
    var details: String
}

