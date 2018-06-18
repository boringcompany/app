//
//  Position.swift
//  Jackal
//
//  Created by Alexander Savonin on 28/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import CoreGraphics

struct Position {    
    let x: CGFloat
    let y: CGFloat
}

// MARK: - Equatable
extension Position: Equatable {
    
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}
