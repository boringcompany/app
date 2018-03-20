//
//  SelectionComponent.swift
//  Jackal
//
//  Created by Anton Tyutin on 19.02.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit

protocol SelectionComponentDelegate: class {
    
    func entitySelected(_ entity: GKEntity)
}


class SelectionComponent: GKComponent {
    
    weak var delegate: SelectionComponentDelegate?
    
    func select() {
        
        if let entity = self.entity {
            self.delegate?.entitySelected(entity)
        }
    }
}
