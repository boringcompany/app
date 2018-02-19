//
//  StartTurnState.swift
//  Jackal
//
//  Created by Anton Tyutin on 19.02.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


class StartTurnState: TurnState {
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        return stateClass == PirateSelectedState.self
    }
    
    
    override func didEnter(from previousState: GKState?) {
        
        for pirate in self.game.pirates {
            
            let inputComponent = pirate.component(ofType: InputHandlingComponent.self)
            inputComponent?.interactionEnabled = true
            
            let selectionComponent = pirate.component(ofType: SelectionComponent.self)
            selectionComponent?.delegate = self
        }
        
        
        for cell in self.game.fieldCells {
            
            let inputComponent = cell.component(ofType: InputHandlingComponent.self)
            inputComponent?.interactionEnabled = false
        }
    }
}


// MARK: - SelectionComponentDelegate

extension StartTurnState: SelectionComponentDelegate {
    
    func entitySelected(_ entity: GKEntity) {
        
        let pirate = entity as! PirateEntity
        self.game.selectedPirate = pirate
        self.stateMachine?.enter(PirateSelectedState.self)
    }
    
    
    func entityDeselected(_ entity: GKEntity) {
        
        assertionFailure("Can't be here")
    }
}
