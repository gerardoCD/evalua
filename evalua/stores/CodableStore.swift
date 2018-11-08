//
//  CodableStore.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/7/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

struct CodableStore<T> where T: Codable {
    let filename: String

    var filePath: URL? {
        var filePath = StorageType.permanent.folder
        filePath.appendPathComponent(filename)
        return filePath
    }

    func load() -> T? {
        guard let path = self.filePath, let data = try? Data(contentsOf: path) else {
            print("Could not load data from \(String(describing: self.filePath))")
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let err {
            print("Could not decode data: \(err.localizedDescription)")
            return nil
        }
    }

    func save(data dataSource: T) {
        guard let data = try? JSONEncoder().encode(dataSource), let path = self.filePath else { return }
        do {
            try data.write(to: path)
        } catch let err {
            print("Could not save file: \(err.localizedDescription)")
        }
    }
}
