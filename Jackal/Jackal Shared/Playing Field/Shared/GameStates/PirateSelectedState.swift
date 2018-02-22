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
        
        return stateClass == StartTurnState.self
            || stateClass == PirateSelectedState.self
    }
    
    
    override func didEnter(from previousState: GKState?) {
        
        let selectedPirate = self.game.selectedPirate!
        
        for pirate in self.game.pirates {
            
            let inputComponent = pirate.component(ofType: InputHandlingComponent.self)
            inputComponent?.interactionEnabled = true
            
            let selectionComponent = pirate.component(ofType: SelectionComponent.self)
            selectionComponent?.delegate = self
        }
        
        let selectedPiratePosition =
            selectedPirate.component(ofType: BoardPositionComponent.self)!.boardPosition!
        
        let availablePositions: Set<BoardPosition> =
            Set(self.game.level.availableDestinations(for: selectedPiratePosition))
        
        for cell in self.game.fieldCells {
            
            guard let cellPosition =
                cell.component(ofType: BoardPositionComponent.self)?.boardPosition else { continue }
            
            let inputComponent = cell.component(ofType: InputHandlingComponent.self)
            inputComponent?.interactionEnabled = availablePositions.contains(cellPosition)
            
            let selectionComponent = cell.component(ofType: SelectionComponent.self)
            selectionComponent?.delegate = self
        }
    }
    
    
    private func movePirate(_ pirate: PirateEntity, to cell: FieldNodeEntity) {
        
        guard
            let cellPosition = cell.component(ofType: BoardPositionComponent.self)?.boardPosition,
            let pirateNode = pirate.component(ofType: NodeComponent.self)?.node
            else { return }
        
        let point = self.game.gameScene.point(at: cellPosition.int2Position)
        
        pirate.component(ofType: BoardPositionComponent.self)?.boardPosition = cellPosition
        
        let action = SKAction.move(to: point, duration: 0.3)
        pirateNode.run(action)
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
            
            self.movePirate(self.game.selectedPirate!, to: cell)
            self.game.selectedPirate?.component(ofType: SelectionComponent.self)?.isSelected = false
            
        default:
            break
        }
    }
    
    
    func entityDeselected(_ entity: GKEntity) {
        
        switch entity {
        case let pirate as PirateEntity where self.game.selectedPirate == pirate:
            
            self.game.selectedPirate = nil
            self.stateMachine?.enter(StartTurnState.self)
            
        default:
            break
        }
    }
}
