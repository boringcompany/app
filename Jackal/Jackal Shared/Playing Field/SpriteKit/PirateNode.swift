//
//  PirateNode.swift
//  Jackal
//
//  Created by Anton Tyutin on 28.01.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import SpriteKit


class PirateNode: SKShapeNode {
    
    
    convenience init(size: CGSize) {
        
        self.init(ellipseOf: size)
        
        self.fillColor = .yellow
    }
}
