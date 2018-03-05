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
    func entityDeselected(_ entity: GKEntity)
}


class SelectionComponent: GKComponent {
    
    weak var delegate: SelectionComponentDelegate?
    
    var isSelected: Bool = false {
        
        didSet {
            
            guard isUserInteractionEnabled, let entity = self.entity else { return }
            
            if isSelected {
                self.delegate?.entitySelected(entity)
            } else {
                self.delegate?.entityDeselected(entity)
            }
        }
    }
    
    var isUserInteractionEnabled: Bool = true
}
