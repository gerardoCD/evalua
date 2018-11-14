//
//  ClassroomsStorage.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/8/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

class ClassroomStorage: ObjectStorage<Classroom> {
    static let shared = ClassroomStorage()
    init() {
        super.init(filename: "classrooms.json")
    }
}
