//
//  Team.swift
//  evalua
//
//  Created by Luis Ezcurdia on 10/30/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

struct Team: Evaluable {
    let name: String
    let github: String
    let repo: String

    // MARK: - Evaluable protocol methods
    var scores: [RubricScore]
    func eval() -> Float {
        return 5.0
    }
}
