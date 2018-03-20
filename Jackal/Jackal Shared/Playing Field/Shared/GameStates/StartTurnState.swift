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
            
            pirate.setSelectable(true)
            
            let selectionComponent = pirate.component(ofType: SelectionComponent.self)
            selectionComponent?.delegate = self
            
            pirate.setHighlighted(false)
        }
        
        
        for cell in self.game.cells {
            
            cell.setSelectable(false)
            cell.setHighlighted(false)
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
}
