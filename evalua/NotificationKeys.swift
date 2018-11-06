//
//  NotificationKeys.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/1/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import Foundation

enum NotificationKeys {
    case team(create: Bool)
    case classroom(create: Bool)

    var name: NSNotification.Name {
        switch self {
        case .team(let create):
            if create {
                return NSNotification.Name(rawValue: "Team#create")
            } else {
                return NSNotification.Name(rawValue: "Team#edit")
            }
        case .classroom(let create):
            if create {
                return NSNotification.Name(rawValue: "Classroom#create")
            } else {
                return NSNotification.Name(rawValue: "Classroom#edit")
            }
        }
    }
}
