//
//  PersistenceManager.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/7/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    var classrooms: [Classroom]
    var rubrics: [Rubric]
    private let classroomsStore = CodableStore<[Classroom]>(filename: "classrooms")
    private let rubricsStore = CodableStore<[Rubric]>(filename: "rubrics")

    init() {
        StorageType.permanent.ensureExists()
        rubrics = rubricsStore.load() ?? [Rubric]()
        classrooms = classroomsStore.load() ?? [Classroom]()
    }

    func save() {
        rubricsStore.save(data: rubrics)
        classroomsStore.save(data: classrooms)
    }
}
