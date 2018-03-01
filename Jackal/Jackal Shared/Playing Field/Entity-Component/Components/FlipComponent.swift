//
//  FlipComponent.swift
//  Jackal
//
//  Created by Andrey Zonov on 01/03/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit

class FlipSpriteComponent: GKComponent {
    
    func flip(to texture: SKTexture) {
        
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            assertionFailure("FlipSpriteComponent is applying for Entity with SpriteComponent")
            return
        }
        
        let node = spriteComponent.node
        
        let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.4)
        let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.4)
        
        node.run(firstHalfFlip) {
            node.texture = texture
            node.run(secondHalfFlip)
        }
    }
}
