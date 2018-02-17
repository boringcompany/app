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
    
    
    func actionIn(event: Event) {
        print("actionIn \(event.coordinate)")
    }
    
    func actionMove(event: Event) {
        print("actionMove \(event.coordinate)")
    }
    
    func actionOut(event: Event) {
        print("actionOut \(event.coordinate)")
    }
}
