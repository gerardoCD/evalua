//
//  Team.swift
//  evalua
//
//  Created by Luis Ezcurdia on 10/30/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation
import UIKit

struct Team: Codable, Evaluable {
    let name: String
    let github: String
    let repo: String

    var githubUrlString: String {
        return "https://github.com/\(self.github)"
    }

    var repoUrlString: String {
        return "\(self.githubUrlString)/\(self.repo)"
    }

    var repoUrl: URL? {
        return URL(string: repoUrlString)
    }

    // MARK: - Evaluable protocol methods
    var scores: [RubricScore]
    func eval() -> Float {
        return 5.0
    }

    func githubImage(_ completion: @escaping (UIImage) -> Void) {
        if let img = ImageStore.shared.fetch(forKey: "\(self.github).png") {
            completion(img)
            return
        }
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: "\(self.githubUrlString).png"),
                let data = try? Data(contentsOf: url),
                let img = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(img)
            }
            ImageStore.shared.save(image: img, forKey: "\(self.github).png")
        }
    }
}
