//
//  InputHandler.swift
//  Jackal
//
//  Created by azonov on 27.01.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation

struct Event {
    let coordinate: (x: Float, y: Float)
}

protocol InputHandlerProtocol {
    
    func actionIn(event: Event)
    func actionMove(event: Event)
    func actionOut(event: Event)
}

class InputHandler: InputHandlerProtocol {
    
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
