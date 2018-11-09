//
//  ObjectStorage.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/8/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

class ObjectStorage<T> where T: Codable & Equatable {
    private var items: [T]
    private let store: CodableStore<[T]>

    init(filename: String) {
        StorageType.permanent.ensureExists()
        store = CodableStore<[T]>(filename: "classrooms.json")
        items = store.load() ?? [T]()
    }

    var all: [T] {
        return items
    }

    var count: Int {
        return items.count
    }

    subscript(index: Int) -> T {
        get {
            return items[index]
        }
        set(item) {
            items.insert(item, at: index)
        }
    }

    func swapAt(_ i: Int, _ j: Int) {
        items.swapAt(i, j)
    }

    func remove(at index: Int) {
        items.remove(at: index)
    }

    func remove(_ item: T) {
        if let index = items.firstIndex(where: { $0 == item }) {
            items.remove(at: index)
        }
    }

    func save() {
        store.save(data: items)
    }
}
