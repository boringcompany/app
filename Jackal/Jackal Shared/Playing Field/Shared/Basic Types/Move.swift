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
    
    init(x: Unit, y: Unit, rotation: Rotation = .none) {
        
        switch rotation {
            
        case .none:
            self.x = x
            self.y = y
            
        case .left90:
            self.x = y * -1
            self.y = x
            
        case .left180:
            self.x = x * -1
            self.y = y * -1
            
        case .left270:
            self.x = y
            self.y = x * -1
        }
    }
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
