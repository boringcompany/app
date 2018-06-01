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
    
    init(x: Unit, y: Unit) {
        
        self.x = x
        self.y = y
    }
    
    func moveWithRotation(_ rotation: Rotation) -> Move {
        
        let x: Unit
        let y: Unit
        
        switch rotation {
            
        case .none:
            x = self.x
            y = self.y
            
        case .left90:
            x = self.y * -1
            y = self.x
            
        case .left180:
            x = self.x * -1
            y = self.y * -1
            
        case .left270:
            x = self.y
            y = self.x * -1
        }
        
        return Move(x: x, y: y)
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
