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
            guard touches.count == 1, let touch = touches.first else { return }
            inputHandler.actionIn(event: touch.location(in: self).rawEvent)
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard touches.count == 1, let touch = touches.first else { return }
            inputHandler.actionMove(event: touch.location(in: self).rawEvent)
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard touches.count == 1, let touch = touches.first else { return }
            inputHandler.actionOut(event: touch.location(in: self).rawEvent)
        }
    }

// Touch-based event handling
extension ControlsScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        inputHandler.actionIn(event: touch.location(in: self).rawEvent)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        inputHandler.actionMove(event: touch.location(in: self).rawEvent)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        inputHandler.actionOut(event: touch.location(in: self).rawEvent)
    }
}
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameScene {
        
        override func mouseDown(with event: NSEvent) {
            inputHandler.actionIn(event: event.location(in: self).rawEvent)
        }
        
        override func mouseDragged(with event: NSEvent) {
            inputHandler.actionMove(event: event.location(in: self).rawEvent)
        }
        
        override func mouseUp(with event: NSEvent) {
            inputHandler.actionOut(event: event.location(in: self).rawEvent)
        }
    }

extension ControlsScene {
    override func mouseDown(with event: NSEvent) {
        inputHandler.actionIn(event: event.location(in: self).rawEvent)
    }
    
    override func mouseDragged(with event: NSEvent) {
        inputHandler.actionMove(event: event.location(in: self).rawEvent)
    }
    
    override func mouseUp(with event: NSEvent) {
        inputHandler.actionOut(event: event.location(in: self).rawEvent)
    }
}
#endif

extension CGPoint {
    
    var rawEvent: Event {
        return Event(coordinate: (x: Float(x), y: Float(y)))
    }
}
