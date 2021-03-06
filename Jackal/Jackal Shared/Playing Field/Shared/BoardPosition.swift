//
//  BoardPosition.swift
//  Jackal
//
//  Created by Anton Tyutin on 29.01.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import SpriteKit


struct BoardPosition {
    
    typealias Unit = Int8
    
    var x: Unit
    var y: Unit
    var z: Unit
    
    init(x: Unit, y: Unit, z: Unit = 0) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(_ x: Unit, _ y: Unit, _ z: Unit = 0) {
        self.init(x: x, y: y, z: z)
    }
    
    init(int2: int2) {
        self.init(x: Unit(int2.x),
                  y: Unit(int2.y),
                  z: 0)
    }
    
    
    var int2Position: int2 {
        return int2(x, y)
    }
}


// MARK: - Hashable

extension BoardPosition: Hashable {
    
    static func ==(lhs: BoardPosition, rhs: BoardPosition) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.z == rhs.z
    }
    
    
    var hashValue: Int {
        let x = Int(self.x) << 16
        let y = Int(self.y) << 8
        let z = Int(self.y)
        return x | y | z
    }
}
