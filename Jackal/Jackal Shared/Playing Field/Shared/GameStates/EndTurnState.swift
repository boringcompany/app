//
//  EndTurnState.swift
//  Jackal
//
//  Created by Anton Tyutin on 20.03.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


class EndTurnState: TurnState {
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        return stateClass == StartTurnState.self
    }
    
    
    override func didEnter(from previousState: GKState?) {
        
        self.game.selectedPirate = nil
        self.game.selectedField = nil
        
        self.stateMachine?.enter(StartTurnState.self)
    }
}
