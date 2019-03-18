//
//  ForegroundView.swift
//  Jackal
//
//  Created by Andrey Zonov on 27/06/2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Cocoa
import SpriteKit

class ForegroundView: SKView {
    
    override func hitTest(_ point: NSPoint) -> NSView? {
        guard let scene = scene,
            !scene.nodes(at: scene.convertPoint(fromView: point)).isEmpty else {
                return nil
        }
        
        return self
    }
}
