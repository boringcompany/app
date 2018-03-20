//
//  PirateSelectedState.swift
//  Jackal
//
//  Created by Anton Tyutin on 19.02.2018.
//  Copyright © 2018 Boring Company. All rights reserved.
//

import Foundation
import GameplayKit


class PirateSelectedState: TurnState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        let isValid = stateClass == PirateSelectedState.self
            || stateClass == FieldSelectedState.self
        
        return isValid
    }
    
    
    override func didEnter(from previousState: GKState?) {
        
        guard let selectedPirate = self.game.selectedPirate else {
            assertionFailure("Cannot enter \(PirateSelectedState.self) without any pirate selected")
            return
        }
        
        for pirate in self.game.pirates {
            
            pirate.setSelectable(true)
            
            let selectionComponent = pirate.component(ofType: SelectionComponent.self)
            selectionComponent?.delegate = self
        }
        
        let selectedPiratePosition =
            selectedPirate.component(ofType: BoardPositionComponent.self)!.boardPosition!
        
        let availablePositions: Set<BoardPosition> =
            Set(self.game.level.availableDestinations(for: selectedPiratePosition))
        
        let filteredAvailablePositions = availablePositions.map { (position) -> BoardPosition in
            return BoardPosition(int2: position.int2Position)
        }
        
        for cell in self.game.fieldCells {
            
            guard let cellPosition =
                cell.component(ofType: BoardPositionComponent.self)?.boardPosition else { continue }
            
            let isCellAvailable = filteredAvailablePositions.contains(cellPosition)
            
            cell.setSelectable(isCellAvailable)
            
            let selectionComponent = cell.component(ofType: SelectionComponent.self)
            selectionComponent?.delegate = self
            
            cell.setHighlighted(isCellAvailable)
        }
    }
}


// MARK: - SelectionComponentDelegate

extension PirateSelectedState: SelectionComponentDelegate {
    
    
    func entitySelected(_ entity: GKEntity) {
        
        switch entity {
        case let pirate as PirateEntity where pirate != self.game.selectedPirate:
            
            self.game.selectedPirate = pirate
            self.stateMachine?.enter(PirateSelectedState.self)
            
        case let cell as FieldNodeEntity:
            
            self.game.selectedField = cell
            self.stateMachine?.enter(FieldSelectedState.self)
            
        default:
            break
        }
    }
}
