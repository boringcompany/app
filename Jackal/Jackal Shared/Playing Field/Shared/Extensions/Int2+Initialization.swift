//
//  Int2+Initialization.swift
//  Jackal
//
//  Created by Andrey Zonov on 26/02/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import SpriteKit

extension int2 {
    
    init(_ x: Int,_ y: Int) {
        assert(x < Int32.max || y < Int32.max, "Out of range!")
        self.init(Int32(x), Int32(y))
    }
    
    init(_ x: Int8,_ y: Int8) {
        self.init(Int32(x), Int32(y))
    }
}
