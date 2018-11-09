//
//  Rubric.swift
//  evalua
//
//  Created by Luis Ezcurdia on 10/30/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

struct Rubric: Codable {
    let name: String
    let weight: Float = 1.0
}

extension Rubric: Equatable {
    static func == (lhs: Rubric, rhs: Rubric) -> Bool {
        return lhs.name == rhs.name && lhs.weight == rhs.weight
    }
}
