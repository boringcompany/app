//
//  GoldNode.swift
//  Jackal
//
//  Created by Andrey Zonov on 14/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import SpriteKit

class GoldSpriteNode: SKShapeNode {
    
    convenience init(size: CGSize) {
        
        self.init(ellipseOf: size)
        
        self.fillColor = .red
    }
}
