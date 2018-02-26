//
//  Move.swift
//  Jackal
//
//  Created by Andrey Zonov on 22/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation

struct Move {
    
    typealias Unit = Int8
    
    let x: Unit
    let y: Unit
}

// MARK: - Hashable
extension Move: Hashable {
    
    static func ==(lhs: Move, rhs: Move) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
    
    
    var hashValue: Int {
        let x = Int(self.x) << MemoryLayout<Int>.size
        let y = Int(self.y)
        return x | y
    }
}
