//
//  InputHandlingComponent.swift
//  Jackal
//
//  Created by Anton Tyutin on 29.01.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class InputHandlingComponent: GKComponent, InputHandlerProtocol {
    
    
    public var interactionEnabled: Bool {
        get {
            
            if let node = self.entity?.component(ofType: NodeComponent.self)?.node {
                return node.isUserInteractionEnabled
            }
            
            if let node = self.entity?.component(ofType: SpriteComponent.self)?.node {
                return node.isUserInteractionEnabled
            }
            
            return false
        }
        
        set {
            
            if let node = self.entity?.component(ofType: NodeComponent.self)?.node {
                node.isUserInteractionEnabled = newValue
            }
            
            if let node = self.entity?.component(ofType: SpriteComponent.self)?.node {
                node.isUserInteractionEnabled = newValue
            }
        }
    }
    
    
    func actionIn(event: Event) {
        print("actionIn \(event.coordinate)")
    }
    
    func actionMove(event: Event) {
        print("actionMove \(event.coordinate)")
    }
    
    func actionOut(event: Event) {
        print("actionOut \(event.coordinate)")
        
        if let selectionComponent = self.entity?.component(ofType: SelectionComponent.self) {
            selectionComponent.isSelected = !selectionComponent.isSelected
        }
    }
}
