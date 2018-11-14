//
//  RubricStorage.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/8/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

class RubricStorage: ObjectStorage<Rubric> {
    static let shared = RubricStorage()
    init() {
        super.init(filename: "rubrics.json")
    }
}
