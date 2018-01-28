//
//  SpriteKit+Inputs.swift
//  Jackal
//
//  Created by azonov on 27.01.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func setupInputs() {
        
    }
}

#if os(iOS) || os(tvOS)
    // Touch-based event handling
    extension GameScene {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        }
    }
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameScene {
        
        override func mouseDown(with event: NSEvent) {
        }
        
        override func mouseDragged(with event: NSEvent) {
        }
        
        override func mouseUp(with event: NSEvent) {
        }
    }
#endif
