//
//  GKEntityExtensions.swift
//  Jackal
//
//  Created by Anton Tyutin on 20.03.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


extension GKEntity {
    
    func setSelectable(_ isSelectable: Bool) {
        
        let inputComponent = self.component(ofType: InputHandlingComponent.self)
        inputComponent?.interactionEnabled = isSelectable
    }
    
    
    func setHighlighted(_ isHighlighted: Bool) {
        
        let spriteComponent = self.component(ofType: SpriteComponent.self)
        if let cellNode = spriteComponent?.node as? CellNode {
            cellNode.highlighted = isHighlighted
        }
    }
}
