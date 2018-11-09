//
//  Classroom.swift
//  evalua
//
//  Created by Luis Ezcurdia on 10/30/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

struct Classroom: Codable {
    private let uuid: String
    let name: String
    var teams: [Team]

    init(name: String) {
        self.uuid = UUID().uuidString
        self.name = name
        self.teams = [Team]()
    }
}

extension Classroom: Equatable {
    static func == (lhs: Classroom, rhs: Classroom) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
