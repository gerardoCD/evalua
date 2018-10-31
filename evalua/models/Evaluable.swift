//
//  Evaluable.swift
//  evalua
//
//  Created by Luis Ezcurdia on 10/30/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

protocol Evaluable {
    var scores: [RubricScore] { get set }
    func eval() -> Float
}
