//
//  Team.swift
//  evalua
//
//  Created by Luis Ezcurdia on 10/30/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation
import UIKit

struct Team: Evaluable {
    let name: String
    let github: String
    let repo: String

    // MARK: - Evaluable protocol methods
    var scores: [RubricScore]
    func eval() -> Float {
        return 5.0
    }
    
    func githubImage(_ completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: "https://github.com/\(self.github).png"),
                let data = try? Data(contentsOf: url),
                let img = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(img)
            }
        }
    }
}
