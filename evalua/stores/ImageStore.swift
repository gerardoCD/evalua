//
//  ImageStore.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/7/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation
import UIKit

class ImageStore {
    static let shared = ImageStore()
    private let cache = NSCache<NSString, UIImage>()

    private func imageURL(forKey key: String) -> URL {
        var directory = StorageType.cache.folder
        directory.appendPathComponent(key)
        return directory
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        let url = imageURL(forKey: key)
        if let data = image.pngData() {
            try? data.write(to: url, options: [.atomic])
        }
    }

    func fetch(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }

        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }

        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }

    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
}
