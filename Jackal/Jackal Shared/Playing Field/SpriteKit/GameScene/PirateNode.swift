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
    
    var inputHandler: InputHandlerProtocol?
    
    convenience init(size: CGSize) {
        
        self.init(ellipseOf: size)
        
        self.fillColor = .yellow
    }
    
    
    #if os(iOS) || os(tvOS)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        inputHandler?.actionIn(event: touch.location(in: self).rawEvent)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        inputHandler?.actionMove(event: touch.location(in: self).rawEvent)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1, let touch = touches.first else { return }
        inputHandler?.actionOut(event: touch.location(in: self).rawEvent)
    }
    
    #endif
    
    #if os(OSX)
    // Mouse-based event handling
    
    
    override func mouseDown(with event: NSEvent) {
        inputHandler?.actionIn(event: event.location(in: self).rawEvent)
        nextResponder?.mouseDown(with: event)
    }
    
    override func mouseDragged(with event: NSEvent) {
        inputHandler?.actionMove(event: event.location(in: self).rawEvent)
        nextResponder?.mouseDragged(with: event)
    }
    
    override func mouseUp(with event: NSEvent) {
        inputHandler?.actionOut(event: event.location(in: self).rawEvent)
        nextResponder?.mouseUp(with: event)
    }
    #endif
}
